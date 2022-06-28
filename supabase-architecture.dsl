workspace "Supabase" "This is the C4 model of supabase" {

    model {
        user = person "App User" "An user who uses the application"
        developer = person "Developer" "A developer who uses supabase"
        configurationUser = person "Configuration User" "A regular business user who can also configure the parameters used in the risk calculations."
        
        supabaseClient = softwareSystem "Supabase Client Libraries" {
            supabasejs = container "supabasejs" "An isomorphic Javascript client for Supabase." {
                url https://github.com/supabase/supabase-js
                technology "TypeScript"
            }

            gotruejs = container "gotruejs" "An isomorphic Javascript library for GoTrue." {
                url https://github.com/supabase/gotrue-js
                technology "TypeScript"
            }
        }

        supabase = softwareSystem "Supabase" {
            
            dashboard = container "Dashboard" {
                
            }
          
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
            
            pgmeta = container "postgres-meta" "providing a RESTful API to managing all metadata of PostgreSQL databases" {
                url https://github.com/supabase/postgres-meta
            }

            postgresql = container "Postgres" "as database management system as main part of supabase" {
                technology "TypeScript"
                url https://github.com/supabase/postgres
            }
        } 

        storage = softwareSystem "S3 Storage Provider" {
            s3Storage = container "AWS S3 Storage" {
                
            }
            wasabi = container "Wasabi" {
                
            }
            backblaze = container "Backblaze" {
                
            }
        }
        
        
        user -> supabaseClient
        supabaseClient -> kong
        dashboard -> kong
        kong -> goTrue
        kong -> postgrest
        kong -> realtime
        kong -> storageApi
        kong -> pgmeta
        goTrue -> postgresql
        postgrest -> postgresql
        realtime -> postgresql
        storageApi -> postgresql
        storageApi -> s3Storage
        storageApi -> gotTrue
        pgmeta -> postgresql
        supabasejs -> gotruejs
        supabasejs -> kong
        goruejs -> kong
    }
         
    views {

        container supabase "Supabase" "app.supabase.com" {
            include *
            autoLayout
        }

        container supabaseClient "Supabase-Clients" "Supabase Client Libraries" {
            include *
            autoLayout
        }

        styles {
           
       }

    }
}
