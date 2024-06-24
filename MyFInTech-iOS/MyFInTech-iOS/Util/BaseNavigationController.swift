import UIKit

class BaseNavigationController: UINavigationController {
    private var backButtonImage: UIImage? {
        return UIImage(systemName: "chevron.backward")!
            .withAlignmentRectInsets(UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0))
    }

    private var backButtonAppearance: UIBarButtonItemAppearance {
        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        return backButtonAppearance
    }

    static func makeNavigationController(rootViewController: UIViewController) -> BaseNavigationController {
        let navigationController = BaseNavigationController(rootViewController: rootViewController)
        navigationController.modalPresentationStyle = .fullScreen
        return navigationController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarAppearance()
    }

    func setNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        navigationBar.tintColor = .gray8
        appearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
        appearance.configureWithTransparentBackground()
        appearance.backButtonAppearance = backButtonAppearance
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
}
