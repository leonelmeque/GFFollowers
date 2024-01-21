import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        
        let searchNC = UINavigationController(rootViewController: SearchVC())
        let favoriteNC = UINavigationController(rootViewController: FavoritesListVC())
        
        searchNC.title = "Search"
        favoriteNC.title = "Favorites"
        
        searchNC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        favoriteNC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        setViewControllers([searchNC, favoriteNC], animated: true)
        tabBar.tintColor = .label
        
        UINavigationBar.appearance().tintColor = .systemTeal
    }
}


#Preview {
    let mainTabBarViewController = MainTabBarViewController()
    return mainTabBarViewController
}
