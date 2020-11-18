# witcom-charts
WiTCOM Helm-Chart repository

### How It Works

I set up GitHub Pages to point to the `docs` folder. From there, I can
create and publish docs like this:

```console
$ helm create mychart
$ helm package mychart
$ mv mychart-0.1.0.tgz docs
$ helm repo index docs --url https://witcom-gmbh.github.io/witcom-charts/
$ git add -i
$ git commit -av
$ git push origin main
```

From there, I can do a `helm repo add tscharts
https://witcom-gmbh.github.io/witcom-charts`
