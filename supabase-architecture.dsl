workspace "Supabase" "This is the C4 model of supabase" {

    model {
        user = person "App User" "An user who uses the application"
        developer = person "Developer" "A developer who uses supabase"
        configurationUser = person "Configuration User" "A regular business user who can also configure the parameters used in the risk calculations."
        
        application = softwareSystem "An application who consumes the REST APIs of Supabase" {
            
         }

        dashboard = softwareSystem "Supabase Dashboard"
        
        supabase = softwareSystem "Supabase" {
            
            kong = container "Kong" "API Gateway" {
                url https://konghq.com/kong
            }
            
            goTrue = container "GoTrue" "An SWT based API for managing users and issuing SWT tokens" {
                url https://github.com/netlify/gotrue
            }
            
            postgrest = container "PostgREST" "turns the PostgreSQL database directly into a RESTful API." {
                url https://postgrest.org/en/stable/
            }
            
            realtime = container "Realtime" "Listen to your to PostgreSQL database in realtime via websockets." {
                url https://github.com/supabase/realtime,
                technology "Elixir"
            }
            
            storageApi = container "Storage API" "S3 compatible object storage service with Postgres and GoTrue" {
                url https://github.com/supabase/storage-api,
                technology "TypeScript"
            }
            
            pgmeta = container "postgres-meta" "providing a RESTful API to managing PostgreSQL databases" {
                
            }

            postgresql = container "PostgreSQL" "as database management system as main part of supabase" {
                
            }
        } 

        storage = softwareSystem "Supabase Storage" {
            s3Storage = container "AWS S3 Storage" {
                
            }
            wasabi = container "Wasabi" {
                
            }
            backblaze = container "Backblaze" {
                
            }
        }
        
        
        user -> application
        application -> kong
        dashboard -> kong
        kong -> goTrue
        kong -> postgrest
        kong -> realtime
        kong -> storage
        kong -> pgmeta
        goTrue -> postgresql
        postgrest -> postgresql
        realtime -> postgresql
        storageApi -> postgresql
        storageApi -> s3Storage
        pgmeta -> postgresql
    }
         
    views {
    
        systemlandscape "SystemLandscape" {
            include *
            autoLayout
        }

        container supabase "Context-1" "app.supabase.com" {
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
