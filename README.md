# kube-config

Repository dedicata alla **gestione centralizzata dei manifest Kubernetes** (YAML) per i vari progetti presenti su GitHub.

L’obiettivo è avere una struttura chiara e riutilizzabile per definire **Deployment, Service, Ingress, Secret e altri manifest** per i diversi progetti, mantenendo configurazioni versionate e facilmente aggiornabili.

## Scopo

- Centralizzare i manifest Kubernetes per più progetti
- Standardizzare la struttura dei manifest tra progetti diversi
- Facilitare deploy e rollback (immagini, variabili d’ambiente, risorse)
- Fornire script di utilità per operazioni ripetitive (creazione namespace, secrets, apply)
- Ogni progetto ha una propria cartella (es. `<nome-progetto>/`).

## Uso rapido (comandi utili)

1) Eseguire gli scripts bash nella cartella `scripts/` per creare namespace, applicare manifest e creare/aggiornare secrets.

3) Verifiche e debug:

```bash
kubectl get pods -n eoq
kubectl logs -f <pod-name> -n eoq
kubectl describe pod <pod-name> -n eoq
kubectl get svc -n eoq
kubectl port-forward -n eoq svc/<service-name> 8000:<service-port>
```

## Namespace e risoluzione dei Service

- I `Service` sono namespaced. Se un Service si chiama `db-service` nel namespace `tirocinio-smart`, il suo FQDN è:
  `db-service.tirocinio-smart.svc.cluster.local`
- Se la tua applicazione è in un namespace diverso, nel `ConfigMap` o nelle variabili d'ambiente usa il FQDN completo oppure sposta l'app nello stesso namespace.

Esempio di host da usare in `ConfigMap`:

```
DB_HOST: db-service.tirocinio-smart.svc.cluster.local
DB_PORT: "3306"
```

## Kafka e Zookeeper

- Per connettere client a Kafka nel cluster, crea un `Service` per Kafka (ClusterIP) e usa `kafka-service:9092` (se client è nello stesso namespace) oppure `kafka-service.<namespace>.svc.cluster.local:9092`.
- Se vuoi che Kafka aspetti Zookeeper al boot, usa un `initContainer` nel pod Kafka che fa polling della porta 2181 di Zookeeper (ovviamente si presuppone che stiate provando tutto in locale).

## Note su `ExternalName` e integrazione con host

- `type: ExternalName` crea solo un record DNS (CNAME) che punta a un hostname esterno (es. `host.docker.internal`). Non crea Endpoints e non instrada traffico direttamente. Verifica che il nome risolva e che il servizio esterno sia raggiungibile dal cluster.
- Per esporre un DB esterno al cluster in modo affidabile puoi usare un `Service` + `Endpoints` che puntano all'IP esterno.

## Best practice rapide

- Non commitare segreti in chiaro nel repo. Usa `kubectl create secret --from-file` o `stringData`/`--from-literal` localmente.
- Definisci `readinessProbe` e `livenessProbe` per i Pod critici.
- Per dipendenze tra servizi (es. Kafka -> Zookeeper) usa `initContainers` o readiness probe anziché aspettarti un ordine d'avvio da Kubernetes.
- Usa `kubectl apply -f <directory>` per applicare più manifest in modo dichiarativo.

Sviluppato da Antonio Basileo.
