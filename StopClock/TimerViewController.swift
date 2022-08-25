//
//  ViewController.swift
//  StopClock
//
//  Created by Naveen Reddy on 23/08/22.
//

import UIKit

class TimerViewController: UIViewController {
    
    //MARK: - Outlet Properties
    @IBOutlet private weak var startButton: UIButton?
    @IBOutlet private weak var stopButton: UIButton?
    @IBOutlet private weak var timeLabel: UILabel!
    
    private
    var startState: ButtonState = .start(.start)
    var stopState: ButtonState = .stop(.stop)

    private
    lazy var stopTimer = StopTimer { [weak self] timeInterval in
        guard let strongSelf = self else { return }
        strongSelf.timeLabel.text = timeInterval.timeString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsRounded()
        self.stopButton?.isHidden = true
    }
    
    //MARK: - Button Actions
    @IBAction func startButtonAction() {
        handleState(state: self.startState)
    }
    
    @IBAction func stopButtonAction() {
        self.handleState(state: self.stopState)
    }
}


extension TimerViewController {
    
    //MARK: - Handling State
    private func handleState(state: ButtonState) {
        switch state {
        case .start(let currentState):
            switch currentState {
            case .start:
                self.stopButton?.isHidden = false
                self.startState = .start(.pause)
                updateStartButton(title: string.pause)
                
                // Start Timer
                self.stopTimer.toggle()
            case .pause:
                self.startState = .start(.resume)
                updateStartButton(title: string.resume)
                self.stopButton?.isHidden = false
                self.stopTimer.pause()

            case .resume:
                print("-----")
                self.startButton?.alpha = 0.25
                self.startButton?.isUserInteractionEnabled = false
                self.stopTimer.toggle()
            }
        case .stop(let currentState):
            switch currentState {
            case .stop:
                self.stopState = .stop(.reset)
                self.updateStopButton(title: string.reset)
                self.startButton?.alpha = 0.25
                self.startButton?.isUserInteractionEnabled = false
                self.stopTimer.pause()
            case .reset:
                self.startState = .start(.start)
                self.stopState = .stop(.stop)
                self.updateStartButton(title: string.start)
                self.updateStopButton(title: string.stop)
                self.startButton?.alpha = 1
                self.startButton?.isUserInteractionEnabled = true
                self.stopButton?.isHidden = true
                self.stopTimer.stop()
            }
        }
    }
    
    //MARK: - Functions
    private func updateStartButton(title: String) {
        self.startButton?.setTitle(title, for: .normal)
    }
    
    private func updateStopButton(title: String) {
        self.stopButton?.setTitle(title, for: .normal)
    }
    
    private func makeButtonsRounded() {
        self.startButton?.applayCornerRadius()
        self.stopButton?.applayCornerRadius()
    }
}

