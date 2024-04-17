# proyecto-x **s3**
Documentación de templates de terraform para el despliegue de buckets en AWS S3 (Betta Cloud)
# Desafío Técnico de Terraform - Creación de Escenarios de S3

En este desafío técnico, trabajamos con Terraform para configurar diferentes escenarios de almacenamiento en Amazon Simple Storage Service (S3). A continuación, describimos los tres escenarios abordados:

## Estructura de carpetas
```
.
├── Modulo S3
│   ├── main.tf
│   ├── modules
│   │   ├── s3-crr
│   │   │   ├── iam-source.tf
│   │   │   ├── locals.tf
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   ├── s3-dest.tf
│   │   │   ├── s3-source.tf
│   │   │   └── variables.tf
│   │   ├── s3_buckets
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── s3_buckets_web
│   │       ├── error.html
│   │       ├── index.html
│   │       ├── main.tf
│   │       ├── outputs.tf
│   │       └── variables.tf
│   ├── outputs.tf
│   └── variables.tf
```

## Escenario 1: Creación de Bucket S3 Simple

En este escenario, creamos un bucket S3 básico con las siguientes características:

- **Versionado Habilitado:** El versionado del bucket está activado, lo que permite mantener múltiples versiones de un mismo objeto.
- **Server-Side Encryption (SSE) Habilitado:** La encriptación del lado del servidor está activada para garantizar la seguridad de los datos almacenados.
- **Preservación de Delete Markers:** Cuando se habilita el versionado, los marcadores de eliminación (delete markers) se preservan, lo que garantiza que las eliminaciones de objetos no sean permanentes.

Este escenario se implementa a través de un módulo de Terraform que permite configurar la cantidad de buckets que se desean desplegar mediante un local llamado `bucket_count`.

**terraform plan -target=module.buckets** de este escenario

```
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.buckets.aws_s3_bucket.buckets[0] will be created
  + resource "aws_s3_bucket" "buckets" {
      + acceleration_status         = (known after apply)
      + acl                         = "private"
      + arn                         = (known after apply)
      + bucket                      = "bucket-proyecto-x-0"
      + bucket_domain_name          = (known after apply)
      + bucket_prefix               = (known after apply)
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = false
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + object_lock_enabled         = (known after apply)
      + policy                      = (known after apply)
      + region                      = (known after apply)
      + request_payer               = (known after apply)
      + tags_all                    = (known after apply)
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)

      + server_side_encryption_configuration {
          + rule {
              + apply_server_side_encryption_by_default {
                  + sse_algorithm = "AES256"
                }
            }
        }

      + versioning {
          + enabled    = true
          + mfa_delete = false
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.
```

## Escenario 2: Creación de Bucket S3 con Static Web Hosting

En este segundo escenario, extendemos el escenario anterior agregando la funcionalidad de Static Web Hosting al bucket S3. Además de las características del escenario anterior, este escenario incluye lo siguiente:

- **Static Web Hosting Habilitado:** Se habilita el hosting web estático en el bucket S3, permitiendo alojar y servir páginas web estáticas directamente desde el bucket.
- **Archivos Index.html y Error.html:** Se cargan y configuran los archivos `index.html` y `error.html` en el bucket S3 para servir como página de inicio y página de error, respectivamente.

Este escenario también se implementa mediante un módulo de Terraform que permite configurar la cantidad de buckets a desplegar.

**terraform plan -target=module.buckets_web** de este escenario

```
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.buckets_web.aws_s3_bucket.static_website[0] will be created
  + resource "aws_s3_bucket" "static_website" {
      + acceleration_status         = (known after apply)
      + acl                         = "private"
      + arn                         = (known after apply)
      + bucket                      = "bucket-proyecto-x-us-east-1-0"
      + bucket_domain_name          = (known after apply)
      + bucket_prefix               = (known after apply)
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = false
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + object_lock_enabled         = (known after apply)
      + policy                      = (known after apply)
      + region                      = (known after apply)
      + request_payer               = (known after apply)
      + tags_all                    = (known after apply)
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)

      + server_side_encryption_configuration {
          + rule {
              + apply_server_side_encryption_by_default {
                  + sse_algorithm = "AES256"
                }
            }
        }

      + versioning {
          + enabled    = true
          + mfa_delete = false
        }

      + website {
          + error_document = "error.html"
          + index_document = "index.html"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

```


## Escenario 3: Configuración de Replicación entre Buckets S3 en Regiones Diferentes

En el tercer escenario, se establece la replicación de objetos entre dos buckets S3 ubicados en diferentes regiones de AWS. Las características clave de este escenario son:

- **Replicación entre Regiones:** Se configura la replicación de objetos entre dos buckets S3 ubicados en las regiones `us-east-1` y `us-west-2`.

**terraform plan -target=module.s3-crr** de este último escenario
```
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  + create
Terraform will perform the following actions:
# module.s3-crr.aws_iam_access_key.source_writer will be created
  + resource "aws_iam_access_key" "source_writer" {
      + create_date                    = (known after apply)
      + encrypted_secret               = (known after apply)
      + encrypted_ses_smtp_password_v4 = (known after apply)
      + id                             = (known after apply)
      + key_fingerprint                = (known after apply)
      + secret                         = (sensitive value)
      + ses_smtp_password_v4           = (sensitive value)
      + status                         = "Active"
      + user                           = "tf-my-replication-name-source-write-user"
    }
# module.s3-crr.aws_iam_policy.source_replication will be created
  + resource "aws_iam_policy" "source_replication" {
      + arn       = (known after apply)
      + id        = (known after apply)
      + name      = "tf-my-replication-name-replication-policy"
      + path      = "/"
      + policy    = jsonencode(
            {
              + Statement = [
                  + {
                      + Action   = [
                          + "s3:ListBucket",
                          + "s3:GetReplicationConfiguration",
                        ]
                      + Effect   = "Allow"
                      + Resource = "arn:aws:s3:::proyecto-x-bucket-source1"
                      + Sid      = ""
                    },
                  + {
                      + Action   = [
                          + "s3:GetObjectVersionForReplication",
                          + "s3:GetObjectVersionAcl",
                        ]
                      + Effect   = "Allow"
                      + Resource = "arn:aws:s3:::proyecto-x-bucket-source1/*"
                      + Sid      = ""
                    },
                  + {
                      + Action   = [
                          + "s3:ReplicateObject",
                          + "s3:ReplicateDelete",
                          + "s3:ObjectOwnerOverrideToBucketOwner",
                        ]
                      + Effect   = "Allow"
                      + Resource = "arn:aws:s3:::replica-proyecto-x-bucket-source1/*"
                      + Sid      = ""
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + policy_id = (known after apply)
      + tags_all  = (known after apply)
    }
# module.s3-crr.aws_iam_policy.source_writer will be created
  + resource "aws_iam_policy" "source_writer" {
      + arn         = (known after apply)
      + id          = (known after apply)
      + name        = (known after apply)
      + name_prefix = "tf-my-replication-name-source-write-"
      + path        = "/"
      + policy      = jsonencode(
            {
              + Statement = [
                  + {
                      + Action   = "s3:PutObject"
                      + Effect   = "Allow"
                      + Resource = "arn:aws:s3:::proyecto-x-bucket-source1/*"
                      + Sid      = ""
                    },
                  + {
                      + Action   = "s3:ListBucket"
                      + Effect   = "Allow"
                      + Resource = "arn:aws:s3:::proyecto-x-bucket-source1"
                      + Sid      = ""
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + policy_id   = (known after apply)
      + tags_all    = (known after apply)
    }
# module.s3-crr.aws_iam_role.source_replication will be created
  + resource "aws_iam_role" "source_replication" {
      + arn                   = (known after apply)
      + assume_role_policy    = jsonencode(
            {
              + Statement = [
                  + {
                      + Action    = "sts:AssumeRole"
                      + Effect    = "Allow"
                      + Principal = {
                          + Service = "s3.amazonaws.com"
                        }
                      + Sid       = ""
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + create_date           = (known after apply)
      + force_detach_policies = false
      + id                    = (known after apply)
      + managed_policy_arns   = (known after apply)
      + max_session_duration  = 3600
      + name                  = "tf-my-replication-name-replication-role"
      + path                  = "/"
      + tags_all              = (known after apply)
      + unique_id             = (known after apply)
+ inline_policy {
          + name   = (known after apply)
          + policy = (known after apply)
        }
    }
# module.s3-crr.aws_iam_role_policy_attachment.source_replication will be created
  + resource "aws_iam_role_policy_attachment" "source_replication" {
      + id         = (known after apply)
      + policy_arn = (known after apply)
      + role       = "tf-my-replication-name-replication-role"
    }
# module.s3-crr.aws_iam_user.source_writer will be created
  + resource "aws_iam_user" "source_writer" {
      + arn           = (known after apply)
      + force_destroy = true
      + id            = (known after apply)
      + name          = "tf-my-replication-name-source-write-user"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }
# module.s3-crr.aws_iam_user_policy_attachment.source_writer will be created
  + resource "aws_iam_user_policy_attachment" "source_writer" {
      + id         = (known after apply)
      + policy_arn = (known after apply)
      + user       = "tf-my-replication-name-source-write-user"
    }
# module.s3-crr.aws_s3_bucket.dest[0] will be created
  + resource "aws_s3_bucket" "dest" {
      + acceleration_status         = (known after apply)
      + acl                         = "private"
      + arn                         = (known after apply)
      + bucket                      = "replica-proyecto-x-bucket-source1"
      + bucket_domain_name          = (known after apply)
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = false
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + policy                      = jsonencode(
            {
              + Statement = [
                  + {
                      + Action    = [
                          + "s3:ReplicateObject",
                          + "s3:ReplicateDelete",
                          + "s3:ObjectOwnerOverrideToBucketOwner",
                        ]
                      + Effect    = "Allow"
                      + Principal = {
                          + AWS = "arn:aws:iam::YourAccountId:root"
                        }
                      + Resource  = "arn:aws:s3:::replica-proyecto-x-bucket-source1/*"
                      + Sid       = "replicate-objects-from-YourAccountId-to-prefix-"
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + region                      = (known after apply)
      + request_payer               = (known after apply)
      + tags_all                    = (known after apply)
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)
+ versioning {
          + enabled    = true
          + mfa_delete = false
        }
    }
# module.s3-crr.aws_s3_bucket.source will be created
  + resource "aws_s3_bucket" "source" {
      + acceleration_status         = (known after apply)
      + acl                         = "private"
      + arn                         = (known after apply)
      + bucket                      = "proyecto-x-bucket-source1"
      + bucket_domain_name          = (known after apply)
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = false
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + region                      = (known after apply)
      + request_payer               = (known after apply)
      + tags_all                    = (known after apply)
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)
+ replication_configuration {
          + role = (known after apply)
+ rules {
              + id       = "tf-my-replication-name"
              + priority = 0
              + status   = "Enabled"
+ destination {
                  + account_id    = "YourAccountId"
                  + bucket        = "arn:aws:s3:::replica-proyecto-x-bucket-source1"
                  + storage_class = "STANDARD"
+ access_control_translation {
                      + owner = "Destination"
                    }
                }
            }
        }
+ versioning {
          + enabled    = true
          + mfa_delete = false
        }
    }
Plan: 9 to add, 0 to change, 0 to destroy.
───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if
you run "terraform apply" now.

```

# Fernando Taboada
