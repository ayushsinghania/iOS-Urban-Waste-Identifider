import UIKit
import VisualRecognition

class ResultsTableViewController: UITableViewController {

    var isInitialized = false

    var classifiers: [ClassResult] = [] {
        didSet {
            isInitialized = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 85.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.isScrollEnabled = false
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classifiers.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIDevice.isiPhoneX ? 160 : 125
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard isInitialized else {
            return buildCell(mainText: "Take a photo to begin!")
        }

        // Ensure there is a classifier with 0.5 score or greater
        guard classifiers.count > 0, classifiers[0].score > 0.5 else {
            return buildCell(mainText: "Unrecognized")
        }

        let label = prettifyLabel(label: classifiers[0].className)
        return buildCell(mainText: label, subText: "View Core ML Classification Data ↑")

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let classifier = classifiers[indexPath.row]

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellClassification",
                                                    for: indexPath) as? ResultTableClassificationViewCell else {
            return UITableViewCell()
        }

        cell.title.text = prettifyLabel(label: classifier.className)
        cell.classificationLabel.text = String(classifier.score.truncate(places: 2))
        cell.cellDescription.numberOfLines = 0
        cell.cellDescription.lineBreakMode = .byWordWrapping
        cell.cellDescription.text = classifier.typeHierarchy

        let width = Double(cell.frame.width) * classifier.score
        cell.scoreScale.frame = CGRect(x: 0, y: 0, width: width, height: Double(cell.frame.height))
        cell.scoreScale.updateConstraints()

        let color = classifier.score >= 0.6 ? UIColor(rgb: 0xAEEA00).withAlphaComponent(0.5) :
                                              UIColor(rgb: 0x1D3458).withAlphaComponent(0.1)
        cell.scoreScale.backgroundColor = color

        return cell
    }

    // Remove any underscores from classification label
    func prettifyLabel(label: String) -> String {
        return label.components(separatedBy: "_").joined(separator: " ").capitalized
    }

    func buildCell(mainText: String, subText: String = "") -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellHeader") as? ResultTableHeaderViewCell else {
            return UITableViewCell()
        }

        cell.label.text = mainText
        cell.swipeLabel.text = subText

        return cell
    }
}

extension ResultsTableViewController: PulleyDrawerViewControllerDelegate {

    func collapsedDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat {
        return 84.0
    }

    func partialRevealDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat {
        return 264.0
    }

    func supportedDrawerPositions() -> [PulleyPosition] {
        // You can specify the drawer positions you support. This is the same as: [.open, .partiallyRevealed, .collapsed, .closed]
        return PulleyPosition.all
    }

    func drawerPositionDidChange(drawer: PulleyViewController, bottomSafeArea: CGFloat) {
        tableView.isScrollEnabled = drawer.drawerPosition == .open
    }
}
