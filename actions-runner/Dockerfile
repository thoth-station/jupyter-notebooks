FROM quay.io/cermakm/actions-runner:v2.169.0

USER 0

RUN curl  -L https://mirror.openshift.com/pub/openshift-v3/clients/3.11.153/linux/oc.tar.gz \
	| tar -C /usr/local/bin -xzf - && \
	curl  -o /usr/local/bin/argo -L https://github.com/argoproj/argo/releases/download/v2.4.3/argo-linux-amd64 && \
	chmod +x /usr/local/bin/argo 

USER 1001

ENTRYPOINT [ "/opt/app-root/src/entrypoint" ]
