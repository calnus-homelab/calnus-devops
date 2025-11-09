#!/usr/bin/env bash
set -euo pipefail

mc alias set myminio https://s3.lanfordlabs.com $AWS_ACCESS_KEY_ID  $AWS_SECRET_ACAWS_SECRET_ACCESS_KEY

LOG="/tmp/bootstrap.log"
exec > >(tee -a "$LOG") 2>&1

INSTANCE_NAME="$(hostname)"
NAME_LOWER=$(echo "$INSTANCE_NAME" | tr '[:upper:]' '[:lower:]')

if [[ "$NAME_LOWER" == *"master"* ]]; then
  echo "=== This is a master node: $INSTANCE_NAME ==="
  sudo kubeadm init --pod-network-cidr=172.16.0.0/16 > /tmp/kubeadm-init.log 2>&1

  # Config kubeconfig para ubuntu user

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

  # Aplicar CNI (ejemplo Calico)
  kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml

  # Extraer join command del log y guardarlo en /tmp/join-command.txt
  # (kubeadm imprime un "kubeadm join ..." al final; esto intenta extraerlo)
  grep -A2 "kubeadm join" /tmp/kubeadm-init.log | tr '\n' ' ' | sed 's/\\//g' > /tmp/join-command.txt || true
  echo "Join command saved to /tmp/join-command.txt"
  mc cp /tmp/join-command.txt myminio/kube/join-command.txt
elif [[ "$NAME_LOWER" == *"worker"* ]]; then
  echo "=== Soy worker: $INSTANCE_NAME ==="
  # Espera a que exista /tmp/join-command.txt (si lo vas a crear manualmente o por otro mecanismo)
  if [[ -f /tmp/join-command.txt ]]; then
    echo "Join command file found, executing join..."
    sudo bash -c "$(cat /tmp/join-command.txt) --ignore-preflight-errors=all" > /tmp/kubeadm-join.log 2>&1 || true
  else
    mc cp myminio/kube/join-command.txt /tmp/join-command.txt
    echo "No existe /tmp/join-command.txt, worker no se unirá automáticamente."
    # opcional: esperar un tiempo por si el archivo aparece
    # timeout=300; while [[ ! -f /tmp/join-command.txt && $timeout -gt 0 ]]; do sleep 5; ((timeout-=5)); done
    # luego intentar....
  fi
else
  echo "Tipo de nodo desconocido: $INSTANCE_NAME"
fi

echo "Script finished."
