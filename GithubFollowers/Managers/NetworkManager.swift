import Foundation


enum NetworkErrors: String {
    case invalidURL = "Invalid URL request"
    case invalidServerResponse = "Invalid response from the server. Please try again."
    case invalidData = "Invalid data received from server"
    case requestIncomplete = "Unable to complete your request. Please check your internet connection"
}


class NetworkManager {
    static let shared = NetworkManager()
    let baseURL = "https://api.github.com"
    
    private init(){}
    
    func getFollowers(for username: String, page: Int, completion: @escaping ( [Follower]?, _: NetworkErrors?) -> Void) {
        guard let endpoint = URL(string:"\(baseURL)/users/\(username)/followers?per_page=100&page=\(page)")
        else {
            completion(nil, .invalidURL)
            return}
        
        let task = URLSession.shared.dataTask(with: endpoint) {
            data, response, error in
            
            if let _ = error {
                completion(nil, .requestIncomplete)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil, .invalidServerResponse)
                return
            }
            
            guard let data = data else {
                completion(nil, .invalidData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completion(followers, nil)
            }catch {
                completion(nil, .invalidData)
            }
        }
        
        // this is what starts the network call
        task.resume()
        
    }
}
