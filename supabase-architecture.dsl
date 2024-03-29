workspace "Supabase" "This shows the technical building blocks of Supabase" {

    model {
        user = person "App User" "An user who uses the application"
        developer = person "Developer" "A developer who uses supabase"
        configurationUser = person "Configuration User" "A regular business user who can also configure the parameters used in the risk calculations."

        application = softwareSystem "Your Web Application" {
           
        }
        
        enterprise "Supabase" {
           
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

            supabaseUi = softwareSystem "Supabase UI" "An open-source UI component library inspired by Tailwind and AntDesign." {
                url https://ui.supabase.io/
            }

            supabaseCli = softwareSystem "Supabase CLI" {
                url https://supabase.com/docs/reference/cli/about
            }

            supabaseStudio = softwareSystem "Supabase Studio" {
                studio = container "Supabase Studio" "supabase" {
                    url https://github.com/supabase/supabase/tree/master/studio
                }
            }

            supabaseBackend = softwareSystem "Supabase" "Supabase" {
            
                kong = container "Kong" "API Gateway" {
                    url https://konghq.com/kong
                }
                
                goTrue = container "GoTrue" "An SWT based API for managing users and issuing SWT tokens" "Go" {
                    url https://github.com/netlify/gotrue
                }
                
                postgrest = container "PostgREST" "turns the PostgreSQL database directly into a RESTful API." "Haskell" {
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

                postgresql = container "Postgres" "Database management system as main part of supabase" "C" {
                    url https://github.com/supabase/postgres
                }
                
                pgmeta = container "Postgres-Meta" "providing a RESTful API to managing all metadata of PostgreSQL databases" {
                        url https://github.com/supabase/postgres-meta
                }
            }
        }

        sentry = softwareSystem "Sentry" "Application Monitoring & Tracking System" {
            url https://sentry.io/
        }

        stripe = softwareSystem "Stripe" "Payment Gateway" {
            url https://stripe.com/
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
        supabaseClient -> kong "https"
        supabaseStudio -> kong "https"
        supabaseCli -> kong "https"
        studio -> supabaseUi "UI based on"
        studio -> sentry "Logging"
        studio -> stripe "Payment"
        
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
        functionsjs -> kong "/function"
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

        container supabaseBackend "Supabase" {
            include *
            autoLayout
            exclude "supabaseClient -> realtime" "supabaseClient -> postgrest" "supabaseClient -> goTrue" "supabaseClient -> storageApi"
        }

        container supabaseClient "Supabase-Clients" "Supabase Client Libraries" {
            include *
            autoLayout
        }

        container supabaseStudio "Supabase-Studio" "app.supabase.com" {
            include *
            autoLayout
        }

        styles {
            element "Software System" {
                background #343A40
                color #46BD84  
                colour #46BD84
            }

            element "Container" {
                background #343A40
                color #46BD84
                colour #46BD84  
            }
        }
    }
}
