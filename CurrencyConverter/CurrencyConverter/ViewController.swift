import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var cgbLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func getRatesClicked(_ sender: Any) {
        
        // 1. Request & Session
        // 2. Response & Data
        // 3. Parsing & JSON Serialization
        
        let url = URL(string: "https://data.fixer.io/api/latest?access_key=cd1c0e3d164157996f4cb3d9688f5cd4")
        let session = URLSession.shared
        
        // Closure
        let task = session.dataTask(with: url!) { (data , response, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                // 2. Response & Data
                if let data = data {
                    do {
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any] {
                            
                            // ASYNC
                            DispatchQueue.main.async {
                                if let rates = jsonResponse["rates"] as? [String: Any] {
                                    if let cad = rates["CAD"] as? Double {
                                        self.cadLabel.text = "CAD: \(cad)"
                                    }
                                    if let chf = rates["CHF"] as? Double {
                                        self.chfLabel.text = "CHF: \(chf)"
                                    }
                                    if let gbp = rates["GBP"] as? Double {
                                        self.cgbLabel.text = "GBP: \(gbp)"
                                    }
                                    if let jpy = rates["JPY"] as? Double {
                                        self.jpyLabel.text = "JPY: \(jpy)"
                                    }
                                    if let usd = rates["USD"] as? Double {
                                        self.usdLabel.text = "USD: \(usd)"
                                    }
                                    if let turkishLira = rates["TRY"] as? Double {
                                        self.tryLabel.text = "TRY: \(turkishLira)"
                                    }
                                }
                            }
                        }
                    } catch {
                        print("JSON Serialization error")
                    }
                }
            }
        }
        task.resume()
    }
}
