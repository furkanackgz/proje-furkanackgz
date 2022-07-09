//
//  CurrentAppointmentCell.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 6.07.2022.
//

import UIKit

class CurrentAppointmentCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var ACDCImageView: UIImageView!
    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var kWhLabel: UILabel!
    @IBOutlet weak var socketNumberLabel: UILabel!
    @IBOutlet weak var socketTypeLabel: UILabel!
    @IBOutlet weak var trashButton: UIButton!
    
    // MARK: - Properties
    var helper: AppointmentsTableViewHelper?
    
    var homeView: HomeContract.homeView?
    
    var appointmentID: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Set up ui components
        setupUI()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - didPressTrashButton
    @IBAction func didPressTrashButton(_ sender: Any) {
        
        // Take prepared title and message
        let titleAndMessage = prepareTitleAndMessage()
        
        showAlert(title: titleAndMessage[0],
                  message: titleAndMessage[1])
        
    }
}

// Self related methods
extension CurrentAppointmentCell {
    
    // MARK: - setupUI
    private func setupUI() {
        
        // Set
        contentView.backgroundColor = ThemeManager.color.background
        
        // Set container view
        containerView.backgroundColor = ThemeManager.color.accent
        containerView.clipsToBounds = true
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 8
        containerView.isUserInteractionEnabled = true
        
        // AC DC image view
        ACDCImageView.contentMode = .scaleAspectFit
        
    }
    
    // MARK: - prepareTitleAndMessage
    private func prepareTitleAndMessage() -> [String] {
        
        // Convert date to appropriate format
        let date = getTheExactDate()
        
        // Seperate date and time label
        let parts = dateAndTimeLabel.text?.components(separatedBy: ",")
        
        // Take the time part
        let time = parts?.last
        
        // Unwrap time
        guard let time = time else { return []}
        
        // Unwrap station name
        guard let stationName = stationNameLabel.text else { return []}
        
        // Create the title string
        let title = "Randevu İptali"
        
        // Create the message string
        let message = "\(stationName) istasyonundaki " +
                    "\(date) saat\(time) " +
                    "randevunuz iptal edilecektir."
        
        // Put title and message into string array to return
        let titleAndMessage: [String] = [title,message]
        
        return titleAndMessage
    }
    
    // MARK: - getTheExactDate
    private func getTheExactDate() -> String {
        
        // Unwrap date and time label
        guard let dateAndTimeString = dateAndTimeLabel.text else { return "" }
        
        // Seperate date and time label
        let date = dateAndTimeString.components(separatedBy: ",")[0]
        
        // If date is not today, seperate it and conver
        // appropriate format, if it is today return it as is
        if date != "Bugün" {
            
            // Split the date to year, month and day parts
            let partsOfDate = date.components(separatedBy: " ")
            
            // Assign the parts
            let year = partsOfDate[0]
            let month = partsOfDate[1]
            let day = partsOfDate[2]
            
            let convertedMonth: String?
            
            // Look the month part and convert it
            switch month {
            case "Ocak":
                convertedMonth = "Ocak"
            case "Şub":
                convertedMonth = "Şubat"
            case "Mar":
                convertedMonth = "Mart"
            case "Nis":
                convertedMonth = "Nisan"
            case "May":
                convertedMonth = "Mayıs"
            case "Haz":
                convertedMonth = "Haziran"
            case "Tem":
                convertedMonth = "Temmuz"
            case "Ağus":
                convertedMonth = "Ağustos"
            case "Eyl":
                convertedMonth = "Eylül"
            case "Ekim":
                convertedMonth = "Ekim"
            case "Kas":
                convertedMonth = "Kasım"
            case "Aral":
                convertedMonth = "Aralık"
            default:
                convertedMonth = ""
            }
            
            // Return it in appropriate format
            return "\(day) " + (convertedMonth ?? "") + " \(year)"
            
        } else {
            
            // Return string which is Bugün
            return "bugün"
        }
        
    }
    
    // MARK: - showAlert
    private func showAlert(title: String, message: String) {
        
        // Unwrap home view
        guard let homeView = homeView as? HomeView else { return }
        
        // Assign navigation controller of home view as target view
        guard let targetView = homeView.navigationController else { return }
        
        // Create alert using title and message
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
       
        // Create randevuyu iptal et alert action and add it to the alert
        let randevuyuIptalEt = UIAlertAction(title: "Randevuyu İptal Et",
                                             style: .default) { _ in
            
           // Call didPressTrashButton method in helper
            
        }
        alert.addAction(randevuyuIptalEt)
        
        // Create vazgeç alert action and add it to the alert
        let vazgec = UIAlertAction(title: "Vazgeç", style: .cancel) { _ in
           alert.dismiss(animated: true)
        }
        alert.addAction(vazgec)

        // Present alert on target view
        targetView.present(alert, animated: true, completion: nil)
   }
    
}
