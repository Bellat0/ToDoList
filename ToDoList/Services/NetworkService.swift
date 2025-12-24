//
//  NetworkService.swift
//  ToDoList
//
//  Created by Maxim Tvilinev on 24.12.2025.
//

import Alamofire

class NetworkService {
    static let shared = NetworkService(); private init() {}
    
    func fetchData(completion: @escaping(Result<[TodoDTO], AFError>) -> ()) {
        let urlString = "https://dummyjson.com/todos"
        
        AF.request(urlString)
            .validate()
            .responseDecodable(of: TodosModel.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data.todos))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
