# kube-config

Repository dedicata alla **gestione centralizzata dei manifest Kubernetes** (YAML) per i vari progetti presenti su GitHub.

L’obiettivo è avere una struttura chiara e riutilizzabile per definire **Deployment, Service, Ingress e Secret** dei diversi progetti, mantenendo configurazioni versionate e facilmente aggiornabili.

## Scopo

- Creare e mantenere i file Kubernetes per più progetti GitHub in un unico posto
- Standardizzare la struttura dei manifest tra progetti diversi
- Facilitare deploy e aggiornamenti (immagini, variabili d’ambiente, risorse, ecc.)
- Tenere traccia delle modifiche tramite Git (audit e rollback)

## Struttura della repository

La repo è organizzata per “tipo di risorsa” e poi per progetto:

- `deployment/`  
  Contiene i manifest relativi a **Deployment** e (quando utile) anche i **Service** legati al deploy applicativo.

- `ingress/`  
  Contiene i manifest di **Ingress** (routing HTTP/HTTPS, host, path, TLS, ecc.).

- `secrets/`  
  Contiene i manifest per i **Secret**. (es. credenziali di accesso a database, chiavi API, ecc.)

Ogni progetto ha una propria cartella (es. `deployment/<nome-progetto>/`) con i relativi YAML.

## Convenzioni consigliate

Per mantenere ordine e coerenza:

- Nomi file chiari e prevedibili, ad esempio:
    - `<progetto>-deployment.yaml`
    - `<progetto>-service.yaml`
    - `<progetto>-ingress.yaml`
    - `<progetto>-secret.yaml`

- Separare per ambiente se serve (consigliato quando la repo cresce), ad esempio:
    - `deployment/<progetto>/dev/`
    - `deployment/<progetto>/prod/`

## Come usare i manifest

Applica i manifest con `kubectl` puntando al file o alla cartella del progetto.
