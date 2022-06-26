workspace "Supabase" "This is the C4 model of supabase" {

    model {
        user = person "App User" "An user who uses the application"
        developer = person "Developer" "A developer who uses supabase"
        configurationUser = person "Configuration User" "A regular business user who can also configure the parameters used in the risk calculations."
        
         application = softwareSystem "An application who consumes the REST APIs of Supabase" {
            
         }
        
        supabase = softwareSystem "Supabase" {
            
            kong = container "Kong" "API Gateway" {
            
            }
            
            goTrue = container "GoTue" "An SWT based API for managing users and issuing SWT tokens" {
        
            }
            
            postgrest = container "PostgREST" "turns the PostgreSQL database directly into a RESTful API." {
            
            }
            
            realtime = container "Realtime" "Listen to your to PostgreSQL database in realtime via websockets." {
            
            }
            
            storage = container "Storage" {
                
            }
            
            pgmeta = container "pgMeta" {
                
            }
            
            postgresql = container "postgresql" {
                
            }
        } 
        
        
        user -> application
        application -> kong
        kong -> goTrue
        kong -> postgrest
        kong -> realtime
        kong -> storage
        kong -> pgmeta
        goTrue -> postgresql
        postgrest -> postgresql
        realtime -> postgresql
        storage -> postgresql
        pgmeta -> postgresql
    }
         
    views {
    
        systemlandscape "SystemLandscape" {
            include *
            autoLayout
        }

        container supabase "Context" "An example System Context diagram for the Financial Risk System architecture kata." {
            include *
            animation {
               pgmeta
            }
            autoLayout
        }

        styles {
           
       }

    }
}
