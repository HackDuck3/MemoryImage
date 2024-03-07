//
//  RankingViewController.swift
//  MemoryImage
//
//  Created by Atik Mahbub Adil on 4/3/24.
//

import UIKit
import Supabase

struct ScoreRecord: Decodable {
    let user_name: String
    let user_point: Double
}

class RankingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let supabase = SupabaseClient(supabaseURL: URL(string: "https://ncbqxdgcvkdgrdbfdmxw.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5jYnF4ZGdjdmtkZ3JkYmZkbXh3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTYzMTc1NDEsImV4cCI6MjAxMTg5MzU0MX0.zWGkhRrXm7XKRnJeo6eU-uLm4DCNy4VeTe38W6MYx30")
    var scores: [ScoreRecord] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await fetchRanking()
        }
        // Configura el dataSource y delegate del UITableView
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ScoreCell")
    }

    func fetchRanking() async {
        print("ENTRADA")
        do {
            let response: PostgrestResponse<()> = try await supabase.database
                .from("users")
                .select("user_name, user_point")
                .order("user_point", ascending: false)
                .limit(10)
                .execute()
            //print(response)
            // Verifica si hay datos en la respuesta
            if response.data.isEmpty {
                print("La respuesta no contiene datos.")
            } else {
                do {
                    scores = try JSONDecoder().decode([ScoreRecord].self, from: response.data)
                    tableView.reloadData()
                    print(scores)
                } catch {
                    print("Error al decodificar los datos:", error.localizedDescription)
                }
            }

        } catch {
            print("Error fetching ranking:", error.localizedDescription)
        }
    }

}

extension RankingViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath)
        
        let score = scores[indexPath.row]
        cell.textLabel?.text = "\(score.user_name): \(score.user_point)"
        
        return cell
    }
}
