//
//  MessagesViewController.swift
//  GameUpGPT MessagesExtension
//
//  Created by Koji Wong on 4/3/25.
//

import UIKit
import Messages

// init comment

class MessagesViewController: MSMessagesAppViewController {
    
    var llama = LlamaManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        
        
    }
    
    @IBAction func gaslightClicked(_ sender: Any) {
        
        
        let llamaPrompt = "Act an actor who is acting like a college student. This college student is currently in a breakup, and is trying to gaslight their partner. Create a text message embodying this. This should be about a paragraph long. Use college student casual language."

        llama.requestLlamaAPI(with: llamaPrompt) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let output):
                    if let conversation = self.activeConversation {
                        conversation.insertText(output) { error in
                            if let error = error {
                                print("Failed to insert text: \(error.localizedDescription)")
                            }
                        }
                    } else {
                        print("No active conversation available.")
                    }
                case .failure(let error):
                    print("API request failed: \(error.localizedDescription)")
                }
            }
        }
    }
    
    @IBAction func requestButtonClicked(_ sender: Any) {
        
        let llamaPrompt = "Act like a college student who knows how to flirt subtly. Generate a creative, flirty pickup line message to a smart college girl."

        llama.requestLlamaAPI(with: llamaPrompt) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let output):
                    if let conversation = self.activeConversation {
                        conversation.insertText(output) { error in
                            if let error = error {
                                print("Failed to insert text: \(error.localizedDescription)")
                            }
                        }
                    } else {
                        print("No active conversation available.")
                    }
                case .failure(let error):
                    print("API request failed: \(error.localizedDescription)")
                }
            }
        }
    }
    

//    private func getConversationContext() -> String {
//        guard let conversation = self.activeConversation else {
//            return ""
//        }
//        var context = ""
//        // Iterate through the messages in the conversation.
//        for message in conversation.messages {
//            if let text = message.summaryText {
//                context += "\(text)\n"
//            }
//        }
//        return context
//    }
//    
    
    
    
    // MARK: - Conversation Handling
    
    override func willBecomeActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the inactive to active state.
        // This will happen when the extension is about to present UI.
        
        // Use this method to configure the extension and restore previously stored state.
    }
    
    override func didResignActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the active to inactive state.
        // This will happen when the user dismisses the extension, changes to a different
        // conversation or quits Messages.
        
        // Use this method to release shared resources, save user data, invalidate timers,
        // and store enough state information to restore your extension to its current state
        // in case it is terminated later.
    }
   
    override func didReceive(_ message: MSMessage, conversation: MSConversation) {
        // Called when a message arrives that was generated by another instance of this
        // extension on a remote device.
        
        // Use this method to trigger UI updates in response to the message.
    }
    
    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user taps the send button.
    }
    
    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user deletes the message without sending it.
    
        // Use this to clean up state related to the deleted message.
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called before the extension transitions to a new presentation style.
    
        // Use this method to prepare for the change in presentation style.
    }
    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called after the extension transitions to a new presentation style.
    
        // Use this method to finalize any behaviors associated with the change in presentation style.
    }

}
