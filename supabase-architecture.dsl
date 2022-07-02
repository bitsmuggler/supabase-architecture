workspace "Supabase" "This shows the technical building blocks of Supabase" {

    model {
        user = person "App User" "An user who uses the application"
        developer = person "Developer" "A developer who uses supabase"
        configurationUser = person "Configuration User" "A regular business user who can also configure the parameters used in the risk calculations."

        supabaseClient = softwareSystem "Supabase Client Libraries" {
                url https://supabase.com/docs/reference#client-libraries
            
                supabasejs = container "supabasejs" "supabase-js: An isomorphic Javascript client for Supabase." "TypeScript" {
                    url https://github.com/supabase/supabase-js
                }

                gotruejs = container "gotruejs" "gotrue-js: An isomorphic Javascript library for GoTrue in the context of Supabase" "TypeScript" {
                    url https://github.com/supabase/gotrue-js
                }

                functionsjs = container "functionsjs" "functions-js: JS Client library to interact with Supabase Functions." "TypeScript" {
                    url https://github.com/supabase/functions-js
                }

                postgrestjs = container "postgrestjs" "postgrest-js: Isomorphic JavaScript client for PostgREST. The goal of this library is to make an ORM-like restful interface." "TypeScript" {
                    url https://github.com/supabase/postgrest-js
                }

                realtimejs = container "realitimejs" "realtime-js: Listens to changes in a PostgreSQL Database and via websockets." "TypeScript" {
                    url https://github.com/supabase/realtime-js
                }

                storagejs = container "storagejs" "storage-js: JS Client library to interact with Supabase Storage." "TypeScript"{
                    url https://github.com/supabase/storage-js
                }
        }

        application = softwareSystem "Your Web Application" {
           
        }
        
        enterprise "Supabase" {
           

            supabaseStudio = softwareSystem "Supabase Studio" {
                studio = container "Supabase Studio" "supabase" {
                    url https://github.com/supabase/supabase/tree/master/studio
                }
            }

            supabaseBackend = softwareSystem "Supabase" "A dashboard for managing the self-hosted Supabase project, and used on the hosted platform." {
            
                kong = container "Kong" "API Gateway" {
                    url https://konghq.com/kong
                }
                
                goTrue = container "GoTrue" "An SWT based API for managing users and issuing SWT tokens" {
                    url https://github.com/netlify/gotrue
                }
                
                postgrest = container "PostgREST" "turns the PostgreSQL database directly into a RESTful API." {
                    url https://postgrest.org/en/stable/
                     pggraphql = component "pg_graphql adds GraphQL support to your PostgreSQL database." "PLpgSQL" {
                        url https://github.com/supabase/pg_graphql
                    }
                }
                
                realtime = container "Realtime" "Listen to your to PostgreSQL database in realtime via websockets." "Elixir" {
                    url https://github.com/supabase/realtime,
                }
                
                storageApi = container "Storage API" "S3 compatible object storage service with Postgres and GoTrue" "TypeScript" {
                    url https://github.com/supabase/storage-api,
                }

                postgresql = container "Postgres" "as database management system as main part of supabase" "TypeScript" {
                    url https://github.com/supabase/postgres
                }
                
                pgmeta = container "Postgres-Meta" "providing a RESTful API to managing all metadata of PostgreSQL databases" {
                        url https://github.com/supabase/postgres-meta
                }
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
       
        user -> application
        developer -> supabaseStudio
        
        application -> supabasejs "uses"
        supabaseClient -> kong
        supabaseStudio -> kong
        supabaseClient -> kong
        studio -> kong
        
        kong -> goTrue "/auth"
        kong -> postgrest "/rest"
        kong -> realtime "/realtime"
        kong -> storageApi "/storage"
        kong -> pgmeta "/pg"
        kong -> pggraphql "/rest | /graphql"
        
        goTrue -> postgresql
        postgrest -> postgresql
        realtime -> postgresql
        storageApi -> postgresql
        pgmeta -> postgresql
        storageApi -> s3Storage
        storageApi -> goTrue

        supabasejs -> postgrestjs
        supabasejs -> gotruejs
        supabasejs -> realtimejs
        supabasejs -> storagejs
        supabasejs -> functionsjs
        
        postgrestjs -> postgrest "/rest"
        gotruejs -> goTrue "/auth"
        realtimejs -> realtime "/realtime"
        storagejs -> storageApi "/storage"
    }
         
    views {
    
        systemcontext application "Application-Overview" {
            include *
            animation {
               
            }
            autoLayout
        }
        
        systemcontext supabaseBackend "Supabase-Overview" {
            include *
            animation {
               
            }
            autoLayout
        }

        container supabaseBackend "Supabase" "app.supabase.com" {
            include *
            autoLayout
            exclude "supabaseClient -> realtime" "supabaseClient -> postgrest" "supabaseClient -> goTrue" "supabaseClient -> storageApi"
        }

        container supabaseClient "Supabase-Clients" "Supabase Client Libraries" {
            include *
            autoLayout
        }

        styles {
            element "Software System" {
                background #46BD84
                color #ffffff
            }

            element "Container" {
                background #46BD84
                color #ffffff  
            }
        }

    }
}
