//
//  PanelGestures.swift
//  Aiolos
//
//  Created by Matthias Tretter on 14/07/2017.
//  Copyright © 2017 Matthias Tretter. All rights reserved.
//

import UIKit

// swiftlint:disable file_length

/// Manages Gestures added to the Panel
final class PanelGestures: NSObject {

    private unowned let panel: Panel

    private lazy var horizontalPan: HorizontalPanGestureRecognizer = self.makeHorizontalPanGestureRecognizer()
    private lazy var horizontalHandler: HorizontalHandler = .init(gestures: self)
    private lazy var verticalPan: NoDelayPanGestureRecognizer = self.makeVerticalPanGestureRecognizer()
    private lazy var verticalPanState: VerticalGestureState = .init(handler: self.verticalHandler)
    private lazy var verticalPointerScroll: PointerScrollGestureRecognizer? = self.makeVerticalPointerScrollGestureRecognizer()
    private lazy var verticalPointerScrollState: VerticalGestureState = .init(handler: self.verticalHandler)
    private lazy var verticalHandler: VerticalHandler = .init(gestures: self)

    private var isVerticalPointerScrollEnabled: Bool {
        get { self.verticalPointerScroll?.isEnabled ?? false }
        set { self.verticalPointerScroll?.isEnabled = newValue }
    }

    private var isVerticalPanEnabled: Bool {
        get { self.verticalPan.isEnabled }
        set { self.verticalPan.isEnabled = newValue }
    }

    // MARK: - Properties

    var isVerticalPanActive: Bool {
        guard self.isVerticalPanEnabled else { return false }

        let activeStates: Set<UIGestureRecognizer.State> = [.began, .changed]
        return activeStates.contains(self.verticalPan.state)
    }

    // MARK: - Lifecycle

    init(panel: Panel) {
        self.panel = panel
    }

    // MARK: - PanelGestures

    func install() {
        self.panel.view.addGestureRecognizer(self.horizontalPan)
        self.panel.view.addGestureRecognizer(self.verticalPan)
        if let pointerScroll = self.verticalPointerScroll {
            self.panel.view.addGestureRecognizer(pointerScroll)
        }
        self.configure(with: self.panel.configuration)
    }
    
    func configure(with configuration: Panel.Configuration) {
        self.isVerticalPanEnabled = configuration.gestureResizingMode.isPanningByTouchEnabled
        self.isVerticalPointerScrollEnabled = configuration.gestureResizingMode.isScrollingByPointerEnabled
    }
    
    func cancel() {
        self.horizontalPan.cancel()
        self.verticalPan.cancel()
        self.verticalPointerScroll?.cancel()
    }
}

// MARK: - UIGestureRecognizerDelegate

extension PanelGestures: UIGestureRecognizerDelegate {

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let shouldBegin = self.panel.gestureDelegate?.gestureRecognizerShouldBegin?(gestureRecognizer) {
            return shouldBegin
        }

        switch gestureRecognizer {
        case self.horizontalPan:
            return self.horizontalHandler.shouldStartPan(self.horizontalPan)
        case self.verticalPan, self.verticalPointerScroll:
            return self.verticalHandler.shouldStartPan(gestureRecognizer)
        default:
            return true
        }
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if let shouldRecognize = self.panel.gestureDelegate?.gestureRecognizer?(gestureRecognizer, shouldRecognizeSimultaneouslyWith: otherGestureRecognizer) {
            return shouldRecognize
        }

        return true
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        // horizontal and vertical pan (or pointer scroll) should not happen together
        if gestureRecognizer == self.horizontalPan {
            return otherGestureRecognizer == self.verticalPan || otherGestureRecognizer == self.verticalPointerScroll
        }

        if let shouldRequireFailureOf = self.panel.gestureDelegate?.gestureRecognizer?(gestureRecognizer, shouldRequireFailureOf: otherGestureRecognizer) {
            return shouldRequireFailureOf
        }

        // fail for built-in drag gesture recognizers 🤷‍♂️
        let className = String(describing: type(of: otherGestureRecognizer))
        if className.contains("UIDrag") { return true }

        return false
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if let shouldBeRequiredToFailBy = self.panel.gestureDelegate?.gestureRecognizer?(gestureRecognizer, shouldBeRequiredToFailBy: otherGestureRecognizer) {
            return shouldBeRequiredToFailBy
        }

        return false
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive press: UIPress) -> Bool {
        if let shouldReceivePress = self.panel.gestureDelegate?.gestureRecognizer?(gestureRecognizer, shouldReceive: press) {
            return shouldReceivePress
        }

        return true
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let shouldReceiveTouch = self.panel.gestureDelegate?.gestureRecognizer?(gestureRecognizer, shouldReceive: touch) {
            return shouldReceiveTouch
        }

        return true
    }
}

// MARK: - Private

private extension PanelGestures {

    // MARK: - HorizontalHandler

    final class HorizontalHandler {

        private unowned let gestures: PanelGestures
        private var panel: Panel { return self.gestures.panel }

        init(gestures: PanelGestures) {
            self.gestures = gestures
        }

        func shouldStartPan(_ pan: UIPanGestureRecognizer) -> Bool {
            let velocity = pan.velocity(in: self.panel.view)
            let isPanningHorizontally = abs(velocity.x) > 1.5 * abs(velocity.y)
            guard isPanningHorizontally else { return false }
            guard let contentViewController = self.panel.contentViewController else { return false }
            guard self.gestures.gestureRecognizer(pan, isWithinContentAreaOf: contentViewController) == false else { return false }

            return self.panel.animator.askDelegateAboutStartOfMove()
        }

        @objc
        func handlePan(_ pan: UIPanGestureRecognizer) {
            switch pan.state {
            case .began:
                self.handlePanStarted(pan)
            case .changed:
                self.handlePanChanged(pan)
            case .ended:
                self.handlePanEnded(pan)
            case .cancelled:
                self.handlePanCancelled(pan)
            default:
                break
            }
        }

        private func handlePanStarted(_ pan: UIPanGestureRecognizer) {
            self.gestures.updateResizeHandle()
        }

        private func handlePanChanged(_ pan: UIPanGestureRecognizer) {
            guard let parentView = self.panel.parent?.view else { return }

            func dragOffset(for translation: CGPoint, moveAllowed: Bool) -> CGFloat {
                return moveAllowed ? translation.x : translation.x / 3.0
            }

            let translation = pan.translation(in: parentView)
            let transformation = CGAffineTransform(translationX: translation.x, y: 0.0)
            let originalFrame = self.panel.view.frame.applying(self.panel.view.transform.inverted())
            let targetFrame = originalFrame.applying(transformation)
            let moveAllowed = self.panel.animator.askDelegateAboutMove(to: targetFrame)
            let xOffset = dragOffset(for: translation, moveAllowed: moveAllowed)
            guard xOffset != 0.0 else { return }

            self.panel.animator.performWithoutAnimation { self.panel.view.transform = CGAffineTransform(translationX: xOffset, y: 0.0) }
        }

        private func handlePanEnded(_ pan: UIPanGestureRecognizer) {
            guard let context = self.repositionContext(pan: pan) else { return }

            var instruction = self.panel.animator.notifyDelegateOfMove(to: self.panel.view.frame, context: context)
            if case .hide = instruction, let repositionDelegate = self.panel.repositionDelegate, repositionDelegate.panelCanBeDismissed(self.panel) == false {
                instruction = .none
            }

            switch instruction {
            case .none:
                let originalPosition = self.panel.configuration.position
                let velocity = self.initialVelocity(with: context, targetPosition: originalPosition)
                self.panel.animator.notifyDelegateOfMove(from: originalPosition, to: originalPosition)
                self.animate(to: originalPosition, initialVelocity: velocity)

            case .updatePosition(let position):
                let originalPosition = self.panel.configuration.position
                let velocity = self.initialVelocity(with: context, targetPosition: position)
                self.panel.animator.notifyDelegateOfMove(from: originalPosition, to: position)
                self.animate(to: position, initialVelocity: velocity)

            case .hide:
                let velocity = self.initialVelocityForHiding(with: context)
                self.panel.animator.notifyDelegateOfHide()
                self.animateToHide(initialVelocity: velocity)
            }

            self.cleanUp(pan: pan)
        }

        private func handlePanCancelled(_ pan: UIPanGestureRecognizer) {
            if let context = self.repositionContext(pan: pan) {
                // ignoring instructions in case pan is cancelled
                _ = self.panel.animator.notifyDelegateOfMove(to: self.panel.view.frame, context: context)
            }

            self.panel.animator.animateIfNeeded {
                self.panel.view.transform = .identity
            }

            self.cleanUp(pan: pan)
        }

        private func cleanUp(pan: UIPanGestureRecognizer) {
            self.gestures.updateResizeHandle()
        }

        private func repositionContext(pan: UIPanGestureRecognizer) -> PanelRepositionContext? {
            guard let parentView = self.panel.parent?.view else { return nil }

            // The view is being transformed, thus the frame changes while dragging, hence the correction
            let originalFrame = self.panel.view.frame.applying(self.panel.view.transform.inverted())
            let offset = pan.translation(in: parentView).x
            let velocity = pan.velocity(in: parentView).x

            return PanelRepositionContext(panel: self.panel, parentView: parentView, originalFrame: originalFrame, offset: offset, velocity: velocity)
        }

        private func initialVelocity(with context: PanelRepositionContext, targetPosition: Panel.Configuration.Position) -> CGFloat {
            let originalPosition = self.panel.configuration.position
            let targetOffset = self.panel.horizontalOffset(at: targetPosition)

            let distance = originalPosition != targetPosition ? targetOffset - context.offset : context.offset
            return abs(context.velocity / distance)
        }

        private func initialVelocityForHiding(with context: PanelRepositionContext) -> CGFloat {
//            let transformation = self.panel.animator.transform(for: .horizontal, size: self.panel.view.frame.size)
            let transformation = self.panel.animator.transform(for: self.panel.view.frame.size)
            let distance = transformation.tx - context.offset

            return abs(context.velocity / distance)
        }

        private func animate(to targetPosition: Panel.Configuration.Position, initialVelocity: CGFloat) {
            let targetOffset = self.panel.horizontalOffset(at: targetPosition)
            let timing = Animation.overdamped.makeTiming(with: initialVelocity)

            self.panel.constraints.prepareForHorizontalPanEndAnimation()
            self.panel.configuration.position = targetPosition
            self.panel.animator.animateWithTiming(timing, animations: {
                self.panel.view.transform = CGAffineTransform(translationX: targetOffset, y: 0)
            }, completion: {
                self.panel.animator.performWithoutAnimation {
                    self.panel.view.transform = .identity
                    self.panel.constraints.updateForHorizontalPanEndAnimationCompleted()
//                    self.panel.constraints.updatePositionConstraints(for: targetPosition, margins: self.panel.configuration.margins)
                    self.panel.constraints.updatePositionConstraints(for: targetPosition)
                }
            })
        }

        private func animateToHide(initialVelocity: CGFloat) {
//            let transformation = self.panel.animator.transform(for: .horizontal, size: self.panel.view.frame.size)
            let transformation = self.panel.animator.transform(for: self.panel.view.frame.size)
            let timing = Animation.overdamped.makeTiming(with: initialVelocity)

            self.panel.animator.isMovingFromParent = true
            self.panel.animator.animateWithTiming(timing, animations: {
                self.panel.view.transform = transformation
            }, completion: {
                self.panel.view.transform = .identity
                // We need to reset the 'isMovingFromParent' state
                // so we can actually remove the panel from its parent.
                self.panel.animator.isMovingFromParent = false
//                self.panel.removeFromParent(transition: .none)
                self.panel.removeFromParent()
            })
        }
    }
}


private extension PanelGestures {

    typealias PanOrScrollGestureRecognizer = UIGestureRecognizer & PanGestureRecognizer

    enum StartMode: Equatable {
        case onFixedArea
        case onVerticallyScrollableArea(competingScrollView: UIScrollView)
    }

    struct Constants {
        static let minTranslation: CGFloat = 5.0
    }

    // MARK: - VerticalGestureState

    /// Handles NoDelayPanGestureRecognizer and PointerScrollGestureRecognizer and provides them with state
    final class VerticalGestureState {

        private unowned let handler: VerticalHandler
        private var initialPoint: CGPoint?
        private var currentPoint: CGPoint?

        // MARK: - Properties

        /// Tells us if the gesture has passed the threshold of Constants.minTranslation at least once
        private(set) var didPan: Bool = false
        var startMode: PanelGestures.StartMode = .onFixedArea

        // MARK: - Lifecycle

        init(handler: VerticalHandler) {
            self.handler = handler
        }

        // MARK: - VerticalGestureState

        @objc
        func handlePan(_ pan: PanOrScrollGestureRecognizer) {
            let location = pan.location(in: pan.view?.window)
            self.currentPoint = location

            switch pan.state {
            case .possible:
                break
            case .began:
                self.initialPoint = location

            case .changed:
                self.currentPoint = location
                if self.totalTranslation(in: pan.view).hypotenuse() >= Constants.minTranslation, self.didPan == false {
                    self.didPan = true

                    guard self.totalTranslation(in: pan.view).direction() == .vertical else {
                        pan.state = .cancelled
                        return
                    }
                }

            case .ended, .failed, .cancelled:
                self.handler.handlePan(pan, state: self)
                self.cleanup() // We can't use defer for this because we're in a switch statement
                return

            @unknown default:
                break
            }

            self.handler.handlePan(pan, state: self)
        }

        // MARK: - Private

        private func cleanup() {
            self.didPan = false
            self.startMode = .onFixedArea
        }

        private func totalTranslation(in view: UIView?) -> CGPoint {
            guard let view = view else { return .zero }
            guard let initialPoint = self.initialPoint else { return .zero }
            guard let currentPoint = self.currentPoint else { return .zero }

            return self.translation(from: initialPoint, to: currentPoint, in: view)
        }

        private func translation(from startPoint: CGPoint, to endPoint: CGPoint, in view: UIView) -> CGPoint {
            guard let window = view.window else { return .zero }

            let startPointInView = window.convert(startPoint, to: view)
            let endPointInView = window.convert(endPoint, to: view)

            return CGPoint(x: endPointInView.x - startPointInView.x, y: endPointInView.y - startPointInView.y)
        }
    }

    // MARK: - VerticalHandler

    final class VerticalHandler {

        private unowned let gestures: PanelGestures
        private var panel: Panel { return self.gestures.panel }
        private var originalConfiguration: PanelGestures.Configuration?

        init(gestures: PanelGestures) {
            self.gestures = gestures
        }

        func shouldStartPan(_ pan: UIGestureRecognizer) -> Bool {
            let gestureResizingMode = self.panel.configuration.gestureResizingMode
            if pan == self.gestures.verticalPan && gestureResizingMode.contains(.byTouch) == false { return false }
            if pan == self.gestures.verticalPointerScroll && gestureResizingMode.contains(.byPointerScroll) == false { return false }
            guard let contentViewController = self.panel.contentViewController else { return gestureResizingMode.contains(.handle) }

            let isWithinContentArea = self.gestures.gestureRecognizer(pan, isWithinContentAreaOf: contentViewController)
            guard isWithinContentArea else { return gestureResizingMode.contains(.handle) }

            return self.gestures.gestureRecognizer(pan, isAllowedToStartByContentOf: contentViewController)
        }

        func handlePan(_ pan: PanOrScrollGestureRecognizer, state: VerticalGestureState) {
            switch pan.state {
            case .began:
                self.handlePanStarted(pan, state: state)
            case .changed:
                self.handlePanChanged(pan, state: state)
            case .ended:
                self.handlePanEnded(pan, state: state)
            case .cancelled:
                self.handlePanCancelled(pan)
            default:
                break
            }
        }

        private func handlePanStarted(_ pan: PanOrScrollGestureRecognizer, state: VerticalGestureState) {
            let configuration = PanelGestures.Configuration(mode: self.panel.configuration.mode, animateChanges: self.panel.animator.animateChanges)
            // remember initial state
            self.originalConfiguration = configuration

            if let contentViewController = self.panel.contentViewController {
                if self.gestures.gestureRecognizer(pan, isWithinContentAreaOf: contentViewController), let scrollView = self.gestures.verticallyScrollableView(of: contentViewController, interactingWith: pan) {
                    state.startMode = .onVerticallyScrollableArea(competingScrollView: scrollView)
                } else {
                    state.startMode = .onFixedArea
                }
            }
        }

        private func handlePanDragStart(_ pan: PanOrScrollGestureRecognizer, state: VerticalGestureState) -> Bool {
            self.panel.animator.animateChanges = false
            self.panel.animator.performWithoutAnimation {
                self.panel.constraints.updateForPanStart(with: self.panel.view.frame.size)
            }

            pan.cancelsTouchesInView = true
            self.gestures.updateResizeHandle()

            let velocity = pan.velocity(in: self.panel.view)

            if case .onVerticallyScrollableArea(let scrollView) = state.startMode {
                if velocity.y < 0.0 {
                    // if the gesture scrolls the content, cancel the resizing gesture itself
                    pan.cancel()
                    return false
                } else if velocity.y > 0.0 {
                    // if the gesture would shrink the panel, cancel all gestures on the competing scrollView
                    scrollView.gestureRecognizers?.forEach {
                        $0.cancel()
                    }
                }
            }

            self.panel.animator.notifyDelegateOfResizing()

            return true
        }

        private func handlePanChanged(_ pan: PanOrScrollGestureRecognizer, state: VerticalGestureState) {
            func dragOffset(for translation: CGPoint) -> CGFloat {
                let fudgeFactor: CGFloat = 60.0
                let minSupportedMode: Panel.Configuration.Mode = self.panel.configuration.supportedModes.contains(.compact) ? .compact : .expanded
                let minHeight = self.height(for: minSupportedMode) + fudgeFactor
                let maxHeight = self.panel.constraints.maxHeight - fudgeFactor
                let currentHeight = self.panel.currentHeight

                // slow down resizing if the current height exceeds certain limits
                let isNearingEdge = (currentHeight < minHeight && translation.y > 0.0) || (currentHeight > maxHeight && translation.y < 0.0)
                if isNearingEdge {
                    return translation.y / 3.0
                } else {
                    return translation.y
                }
            }

            let translation = pan.translation(in: self.panel.view)
            let yOffset = dragOffset(for: translation)
            guard yOffset != 0.0 else { return }

            // We reset the translation to get incremental updates from now on
            pan.setTranslation(.zero, in: self.panel.view)

            // However, didPan still works with totalTranslation under the covers
            if state.didPan && pan.cancelsTouchesInView == false {
                guard self.handlePanDragStart(pan, state: state) else { return }
            }

            self.panel.animator.performWithoutAnimation { self.panel.constraints.updateForPan(with: yOffset) }
            self.panel.animator.notifyDelegateOfTransition(to: CGSize(width: self.panel.view.frame.width, height: self.panel.currentHeight))
        }

        private func handlePanEnded(_ pan: PanOrScrollGestureRecognizer, state: VerticalGestureState) {
            guard let originalMode = self.originalConfiguration?.mode else { return }

            self.panel.constraints.updateForPanEnd()
            guard state.didPan || originalMode == .minimal else {
                self.handlePanCancelled(pan)
                return
            }

            let targetMode = self.targetMode(for: pan, state: state)
            let initialVelocity = self.initialVelocity(for: pan, targetMode: targetMode)

            self.animate(to: targetMode, initialVelocity: initialVelocity)
            self.cleanUp(pan: pan)
        }

        private func handlePanCancelled(_ pan: PanOrScrollGestureRecognizer) {
            guard let originalMode = self.originalConfiguration?.mode else { return }

            let currentHeight = self.panel.currentHeight
            self.cleanUp(pan: pan)

            let size = self.panel.size(for: originalMode)
            self.panel.constraints.updateForPanCancelled(with: size)
            if currentHeight != size.height {
                self.panel.animator.notifyDelegateOfTransition(to: size)
            }
        }

        // swiftlint:disable:next cyclomatic_complexity
        private func targetMode(for pan: PanOrScrollGestureRecognizer, state: VerticalGestureState) -> Panel.Configuration.Mode {
            let supportedModes = self.panel.configuration.supportedModes
            guard let originalConfiguration = self.originalConfiguration else { return supportedModes.first! }

            let offset: CGFloat = 100.0
            let minVelocity: CGFloat = 20.0
            let velocity = pan.velocity(in: self.panel.view).y
            let heightCompact = self.height(for: .compact)
            let heightExpanded = self.height(for: .expanded)
            let currentHeight = self.panel.currentHeight

            let isMovingUpwards = velocity < -minVelocity
            let isMovingDownwards = velocity > minVelocity

            // expand to .compact if we "tap" on .minimal
            if isMovingUpwards == false && isMovingDownwards == false && originalConfiguration.mode == .minimal && currentHeight < heightCompact && supportedModes.contains(.compact) {
                return .compact
            }
            // .minimal is only allowed when moving downwards from .compact
            if isMovingDownwards && originalConfiguration.mode == .compact && currentHeight < heightCompact && supportedModes.contains(.minimal) {
                return .minimal
            }
            // if we move up from .minimal we have a higher threshold for .expanded and prefer .compact
            if isMovingUpwards && originalConfiguration.mode == .minimal && currentHeight < heightCompact + 40.0 && supportedModes.contains(.compact) {
                return .compact
            }
            // moving upwards + current size > .expanded -> grow to .fullHeight
            if isMovingUpwards && currentHeight >= heightExpanded && supportedModes.contains(.fullHeight) {
                return .fullHeight
            }
            // moving downwards + current size < .expanded -> shrink to .compact
            if isMovingDownwards && currentHeight <= heightExpanded && supportedModes.contains(.compact) {
                return .compact
            }
            // moving upwards + current size < .expanded -> grow to .expanded/.fullHeight
            if isMovingUpwards && currentHeight <= heightExpanded {
                if supportedModes.contains(.expanded) { return .expanded }
                if supportedModes.contains(.fullHeight) { return .fullHeight }
            }
            // moving downwards + current size > .expanded -> shrink to .compact/.expanded
            if isMovingDownwards && currentHeight >= heightExpanded {
                switch state.startMode {
                case .onFixedArea:
                    if supportedModes.contains(.expanded) { return .expanded }
                    if supportedModes.contains(.compact) { return .compact }
                case .onVerticallyScrollableArea:
                    if supportedModes.contains(.compact) { return .compact }
                }
            }

            // no "movement velocity", check distance from .expanded mode
            let diffToExpanded = currentHeight - heightExpanded

            if diffToExpanded > offset && supportedModes.contains(.fullHeight) {
                return .fullHeight
            } else if diffToExpanded < -offset && supportedModes.contains(.compact) {
                return .compact
            } else if supportedModes.contains(.expanded) {
                return .expanded
            } else {
                return originalConfiguration.mode
            }
        }

        private func cleanUp(pan: PanOrScrollGestureRecognizer) {
            pan.cancelsTouchesInView = false

            guard let originalConfiguration = self.originalConfiguration else { return }

            self.gestures.updateResizeHandle()
            self.panel.animator.animateChanges = originalConfiguration.animateChanges
            self.originalConfiguration = nil
        }

        private func height(for mode: Panel.Configuration.Mode) -> CGFloat {
            if mode == .fullHeight {
                return self.panel.constraints.maxHeight
            } else {
                return self.panel.size(for: mode).height
            }
        }

        private func initialVelocity(for pan: PanOrScrollGestureRecognizer, targetMode: Panel.Configuration.Mode) -> CGFloat {
            let velocity = pan.velocity(in: self.panel.view).y
            let currentHeight = self.panel.currentHeight
            let targetHeight = self.height(for: targetMode)

            let distance = targetHeight - currentHeight
            return abs(velocity / distance)
        }

        private func timing(for initialVelocity: CGFloat) -> UITimingCurveProvider {
            let springTiming = Animation.springy.makeTiming(with: initialVelocity)
            guard let originalConfiguration = self.originalConfiguration else { return springTiming }

            if originalConfiguration.mode == .minimal || initialVelocity < 13.0 {
                return Animation.overdamped.makeTiming(with: initialVelocity)
            } else {
                return springTiming
            }
        }

        private func animate(to targetMode: Panel.Configuration.Mode, initialVelocity: CGFloat) {
            let height = self.height(for: targetMode)
            let size = self.panel.size(for: targetMode)
            let timing = self.timing(for: initialVelocity)

            self.panel.constraints.prepareForPanEndAnimation()
            self.panel.configuration.mode = targetMode
            self.panel.animator.animateWithTiming(timing, animations: {
                self.panel.constraints.updateForPanEndAnimation(to: height)
                self.panel.animator.notifyDelegateOfTransition(to: size)
            }, completion: {
                self.panel.constraints.updateSizeConstraints(for: size)
            })
        }
    }
}

private extension PanelGestures {

    struct Configuration {
        let mode: Panel.Configuration.Mode
        let animateChanges: Bool
    }

    struct Animation {
        let mass: CGFloat
        let stiffness: CGFloat
        let damping: CGFloat

        static let springy: Animation = Animation(mass: 6.0, stiffness: 2400.0, damping: 195.0)
        static let overdamped: Animation = Animation(mass: 6.0, stiffness: 2400.0, damping: 250.0)

        func makeTiming(with velocity: CGFloat) -> UISpringTimingParameters {
            return UISpringTimingParameters(mass: self.mass, stiffness: self.stiffness, damping: self.damping, initialVelocity: CGVector(dx: velocity, dy: velocity))
        }
    }

    func makeHorizontalPanGestureRecognizer() -> HorizontalPanGestureRecognizer {
        let pan = HorizontalPanGestureRecognizer(target: self.horizontalHandler, action: #selector(HorizontalHandler.handlePan))
        pan.delegate = self
        pan.cancelsTouchesInView = true
        pan.detectsPointerScrolling = true
        return pan
    }

    func makeVerticalPointerScrollGestureRecognizer() -> PointerScrollGestureRecognizer? {
        let gesture = PointerScrollGestureRecognizer.make(withTarget: self.verticalPointerScrollState, action: #selector(VerticalGestureState.handlePan))
        gesture?.delegate = self
        gesture?.cancelsTouchesInView = false
        return gesture
    }

    func makeVerticalPanGestureRecognizer() -> NoDelayPanGestureRecognizer {
        let pan = NoDelayPanGestureRecognizer(target: self.verticalPanState, action: #selector(VerticalGestureState.handlePan))
        pan.delegate = self
        pan.cancelsTouchesInView = false
        return pan
    }

    func updateResizeHandle() {
        var isPanning: Bool {
            let states: Set<UIGestureRecognizer.State> = [.began, .changed]
            let isPanningHorizontally = states.contains(self.horizontalPan.state)
            let isPanningVertically = states.contains(self.verticalPan.state)
            let isPointerScrolling = states.contains(self.verticalPointerScroll?.state ?? .failed)

            return isPanningHorizontally || isPanningVertically || isPointerScrolling
        }

//        self.panel.resizeHandle.isResizing = isPanning
    }

    // allow pan gestures to be triggered within non-safe area on top (UINavigationBar)
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, isWithinContentAreaOf contentViewController: UIViewController) -> Bool {
        let offset: CGFloat = 10.0
        let safeAreaTop: CGFloat
        if let navigationController = contentViewController as? UINavigationController {
            safeAreaTop = navigationController.navigationBar.frame.maxY + offset
        } else {
            safeAreaTop = offset
        }

        let location = gestureRecognizer.location(in: self.panel.panelView)
        return location.y >= safeAreaTop
    }

    // allow pan gesture to be triggered when a) there's no scrollView or b) the scrollView can't be scrolled downwards
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, isAllowedToStartByContentOf contentViewController: UIViewController) -> Bool {
        guard self.panel.configuration.gestureResizingMode.contains(.content) else { return false }

        guard let enclosingScrollView = self.verticallyScrollableView(of: contentViewController, interactingWith: gestureRecognizer) else { return true }
        // don't allow resizing gesture if textView is currently text editing
        if let textView = enclosingScrollView as? UITextView, textView.isFirstResponder {
            return false
        }

        return enclosingScrollView.isScrolledToTop
    }

    func verticallyScrollableView(of contentViewController: UIViewController, interactingWith gestureRecognizer: UIGestureRecognizer) -> UIScrollView? {
        let location = gestureRecognizer.location(in: contentViewController.view)
        guard let hitView = contentViewController.view.hitTest(location, with: nil) else { return nil }

        return hitView.findFirstSuperview(ofClass: UIScrollView.self, where: { $0.scrollsVertically })
    }
}

private extension UIView {

    func findFirstSuperview<T>(ofClass viewClass: T.Type, where predicate: (T) -> Bool) -> T? where T: UIView {
        var view: UIView? = self
        while view != nil {
            if let typedView = view as? T, predicate(typedView) {
                break
            }

            view = view?.superview
        }

        return view as? T
    }
}

private extension UIScrollView {

    var isScrolledToTop: Bool {
        return self.contentOffset.y <= -self.contentInset.top
    }

    var scrollsVertically: Bool {
        guard self.isScrollEnabled && self.isUserInteractionEnabled else { return false }

        let visibleHeight = self.bounds.height - self.adjustedContentInset.top - self.adjustedContentInset.bottom
        return self.alwaysBounceVertical || self.contentSize.height > visibleHeight
    }
}

private extension UIGestureRecognizer {

    func cancel() {
        guard self.isEnabled else { return }

        self.isEnabled = false
        self.isEnabled = true
    }
}

private extension Panel {

    var currentHeight: CGFloat {
        return self.constraints.heightConstraint!.constant
    }
}

private extension CGPoint {

    enum Direction {
        case horizontal
        case vertical
    }

    func hypotenuse() -> CGFloat {
        return sqrt(self.x * self.x + self.y * self.y)
    }

    func direction() -> Direction {
        let horizontalDiff = self.x * self.x
        let verticalDiff = self.y * self.y

        return horizontalDiff > verticalDiff ? .horizontal : .vertical
    }
}
