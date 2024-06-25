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
        let appearance2 = UINavigationBarAppearance()
        navigationBar.tintColor = .gray8
        appearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
        appearance2.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
        appearance.backgroundColor = .white
        appearance.configureWithTransparentBackground()
        appearance2.configureWithDefaultBackground()
        appearance.backButtonAppearance = backButtonAppearance
        appearance2.backButtonAppearance = backButtonAppearance
        navigationController?.setNeedsStatusBarAppearanceUpdate()
        navigationBar.standardAppearance = appearance2
        navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.backItem?.title = nil
    }
}
