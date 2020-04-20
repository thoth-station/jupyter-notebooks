FROM quay.io/cermakm/actions-runner:latest

USER 0

RUN curl -sL -o ${APP_ROOT}/src/oc.tar.gz https://mirror.openshift.com/pub/openshift-v3/clients/3.11.153/linux/oc.tar.gz && \
	tar -C ${APP_ROOT}/bin -zxf ${APP_ROOT}/src/oc.tar.gz oc && \
	rm ${APP_ROOT}/src/oc.tar.gz ; \
	curl -sL -o ${APP_ROOT}/bin/argo https://github.com/argoproj/argo/releases/download/v2.4.3/argo-linux-amd64 && \
	chmod +x ${APP_ROOT}/bin/argo

USER 1001
