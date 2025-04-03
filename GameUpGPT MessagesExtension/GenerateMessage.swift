//
//  GenerateMessage.swift
//  GameUpGPT
//
//  Created by Koji Wong on 4/3/25.
//

import Foundation

class LlamaManager {
    
    /// Makes a request to the Llama API with the given prompt.
    func requestLlamaAPI(with prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        // Use the chat completions endpoint.
        guard let url = URL(string: "https://api.llama-api.com/chat/completions") else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        print("found the base url")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Retrieve your API key from Info.plist (or your preferred secure storage)
        guard let apiKey = Bundle.main.infoDictionary?["LLAMA_API_KEY"] as? String else {
            completion(.failure(URLError(.userAuthenticationRequired)))
            return
        }
        print(apiKey)
        print("found the api key")
        
        // Set required headers
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Construct the JSON body using the new chat format.
        let parameters: [String: Any] = [
            "model": "llama3.1-70b",  // Example model identifier; change as needed
            "messages": [
                ["role": "system", "content": "Assistant is a large language model trained by OpenAI."],
                ["role": "user", "content": prompt]
            ],
            "max_tokens": 150,
            "temperature": 0.7
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        print("request http body done")
        
        // Create a data task to perform the request.
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle errors from the network request.
            if let error = error {
                completion(.failure(error))
                print("couldnt do url session")
                return
            }
            
            // Ensure data is not nil.
            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                print("data is nil")
                return
            }
            
            // Try to parse the response JSON.
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let choices = json["choices"] as? [[String: Any]],
                   let firstChoice = choices.first,
                   let message = firstChoice["message"] as? [String: Any],
                   let content = message["content"] as? String {
                    completion(.success(content))
                    print("successful json parse")
                } else {
                    completion(.failure(URLError(.cannotParseResponse)))
                }
            } catch {
                completion(.failure(error))
                print("couldnt json parse")
            }
        }
        
        task.resume()
    }
}
