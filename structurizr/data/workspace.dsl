workspace {

    model {
        user = person "User"
        user2 = person "User2"
        softwareSystem = softwareSystem "Software System" {
            webapp = container "Web Application" {
                user -> this "Uses"
                this -> user2 "Not use"
            }
            container "Database" {
                webapp -> this "Reads from and writes to"
            }
        }
        
    }

    views {
        systemContext softwareSystem {
            include *
            autolayout lr
        }

        container softwareSystem {
            include *
            autolayout lr
        }

        theme default
    }

}
