#!/bin/sh

command='/bin/grype'

debug="${PLUGIN_DEBUG:-false}"
severityCutoff="${PLUGIN_SEVERITY_CUTOFF}"
onlyFixed="${PLUGIN_ONLY_FIXED:-false}"
addCPESIfNone="${PLUGIN_ADD_CPES_IF_NONE:-false}"
byCVE="${PLUGIN_BY_CVE:-false}"
scanDir="${PLUGIN_SCAN_DIR:-.}"
exclude="${PLUGIN_EXCLUDE}"
scanImage="${PLUGIN_SCAN_IMAGE}"
scope="${PLUGIN_SCOPE}"
name="${PLUGIN_NAME}"

if [ -z $name ]; then
  name="${CI_REPO}"
fi

[[ ! -z $severityCutoff  ]] && command="${command} --fail-on ${severityCutoff}"
[[ ! -z $scope  ]] && command="${command} --scope ${scope}"

if $onlyFixed; then
  command="${command} --only-fixed"
fi
if $addCPESIfNone; then
  command="${command} --add-cpes-if-none"
fi
if  $byCVE; then
  command="${command} --by-cve"
fi
if $debug; then
  command="${command} --vv"
fi

command="${command} --name ${name}"

# comma-separated globs, quoted so eval passes them to grype rather than
# letting the shell expand them
if [ -n "${exclude}" ]; then
  for pattern in $(echo "${exclude}" | tr ',' ' '); do
    command="${command} --exclude '${pattern}'"
  done
fi

if [ -z $scanImage ]; then
  command="${command} dir:${scanDir}"
else
  command="${command} registry:${scanImage}"
fi
echo "Executing $command"

eval $command

