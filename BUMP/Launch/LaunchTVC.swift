//
//  LaunchTVC.swift
//  BUMP
//
//  Created by Hunain Ali on 1/10/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import UIKit

class LaunchTVC: UITableViewController {
    
    override init(style: UITableView.Style) {
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var launchFetcher : LaunchFetcher?
    
    var circleArray : [[LaunchCircle]] = [[],[]]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        self.setupSortButton()
        self.setupLaunchFetcher()
    }
    
    func setupTableView() {
        self.tableView.register(SubtitleTableViewCell.classForCoder(), forCellReuseIdentifier: "launchCell")
    }
    
    func setupLaunchFetcher() {
        
        self.launchFetcher = LaunchFetcher()
        self.launchFetcher?.delegate = self
        self.launchFetcher?.monitorLaunchCircles()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return circleArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return circleArray[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "launchCell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        
        let c = circleArray[indexPath.section][indexPath.row]
        
        cell.imageView?.image = self.imageWith(string: c.circleEmoji)
        cell.textLabel?.text = c.circleName
        
        var followString = "· Join   "
        if c.amFollowing() {
            followString = "· j✓   "
        }
        let subString = "\(c.followerIDArray.count) members \(followString)"
        let fullRange = (subString as NSString).range(of: subString)
        let followRange = (subString as NSString).range(of: followString)
        let attributedString = NSMutableAttributedString(string: subString)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.darkGray, range: fullRange)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: Constant.oBlue, range: followRange)
//        attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .caption1).pointSize, weight: .regular), range: followRange)

        cell.detailTextLabel?.attributedText = attributedString
        
        let tapGesture = IndexTapGestureRecognizer(target: self, action: #selector(tappedFollowButton))
        tapGesture.indexPath = indexPath
        cell.detailTextLabel?.isUserInteractionEnabled = true
        cell.detailTextLabel?.addGestureRecognizer(tapGesture)
        
        return cell
    }

    
    func imageWith(string: String?) -> UIImage? {
        let frame = CGRect(x: 0, y: 0, width: 120, height: 200)
        let nameLabel = UILabel(frame: frame)
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = .clear
        nameLabel.textColor = .white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 80)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.text = string
        UIGraphicsBeginImageContext(frame.size)
        if let currentContext = UIGraphicsGetCurrentContext() {
            nameLabel.layer.render(in: currentContext)
            let nameImage = UIGraphicsGetImageFromCurrentImageContext()
            return nameImage
        }
        return nil
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            if self.circleArray[0].isEmpty {
                return nil
            } else {
                return "My Circles"
            }
        } else {
            if self.circleArray[1].isEmpty {
                return nil
            } else {
                return "All"
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.tableView.cellForRow(at: indexPath)?.isSelected = false
        
        let circle = circleArray[indexPath.section][indexPath.row]
        
        CircleManager.shared.launchCircle(circleID: circle.circleID, circleName: circle.circleName, circleEmoji: circle.circleEmoji)
    }
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


class SubtitleTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
