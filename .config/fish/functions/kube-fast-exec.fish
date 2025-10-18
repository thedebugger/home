function kube-fast-exec
  argparse "h/help" "c/container=" "l/label=" -- $argv
  or return # Exit if argparse fails (e.g., --help was called)

  if set -q _flag_help
    echo "Usage: kexec_ckservice [--container <name>] [--label <key>] <component_value> <namespace> <command> [args...]"
    echo ""
    echo "Options:"
    echo "  -c, --container <name>  Specify the container name (default: ck-service)"
    echo "  -l, --label <key>       Specify the label key to filter pods (default: componentname)"
    echo "  -h, --help              Show this help message"
    echo ""
    echo "Arguments:"
    echo "  <component_value>       The value of the label to filter pods (e.g., recsys-configuration-service-prog)"
    echo "  <namespace>             The Kubernetes namespace"
    echo "  <command> [args...]     The command to execute inside the container (e.g., ls -la)"
    echo ""
    echo "Examples:"
    echo "  kexec_ckservice recsys-service prao-rest-port bash"
    echo "  kexec_ckservice --container my-app-container my-other-service default-ns ls /var/log"
    echo "  kexec_ckservice --label app-name my-app-value prod-ns cat /etc/config.conf"
    return 0
  end

  # Assign default values or values from flags using compatible method
  set -l container_name "ck-service"
  if set -q _flag_container; and test -n "$_flag_container"
    set container_name "$_flag_container"
  end

  set -l label_key "componentname"
  if set -q _flag_label; and test -n "$_flag_label"
    set label_key "$_flag_label"
  end

  # Positional arguments are now in $argv
  set -l component_value $argv[1]
  set -l namespace $argv[2]
  set -l exec_command $argv[3..-1] # Remaining arguments are the exec command

  if test -z "$component_value" -o -z "$namespace"
    echo "Error: <component_value> and <namespace> are required." >&2
    kexec_ckservice --help
    return 1
  end

  set -l pod_name (kubectl get pod --field-selector=status.phase=Running -l "$label_key"="$component_value" -n "$namespace" -o jsonpath='{.items[0].metadata.name}')

  if test -z "$pod_name"
    echo "Error: No pod found for $label_key='$component_value' in namespace '$namespace'." >&2
    return 1
  end

  if test -z "$exec_command"
    echo "No exec command provided. Attempting to start interactive shell (bash or sh)..."
    kubectl exec -it "$pod_name" -c "$container_name" -n "$namespace" -- bash || \
    kubectl exec -it "$pod_name" -c "$container_name" -n "$namespace" -- sh
  else
    kubectl exec -it "$pod_name" -c "$container_name" -n "$namespace" -- $exec_command
  end
end

