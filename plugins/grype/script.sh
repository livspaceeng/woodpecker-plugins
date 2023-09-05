#!/bin/sh

command='/bin/grype'

debug="${PLUGIN_DEBUG:-false}"
severityCutoff="${PLUGIN_SEVERITY_CUTOFF}"
onlyFixed="${PLUGIN_ONLY_FIXED:-false}"
addCPESIfNone="${PLUGIN_ADD_CPES_IF_NONE:-false}"
byCVE="${PLUGIN_BY_CVE:-false}"
scanDir="${PLUGIN_SCAN_DIR:-.}"
scanImage="${PLUGIN_SCAN_IMAGE}"
scope="${PLUGIN_SCOPE}"

[[ ! -z $severityCutoff  ]] && command="${command} --fail-build ${severityCutoff}"
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
if [ -z $scanImage ]; then
  command="${command} ${scanDir}"
else
  command="${command} ${scanImage}"
fi
echo "Executing $command"

eval $command

