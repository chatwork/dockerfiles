file:
  /fluentd/entrypoint.sh:
    exists: true
    mode: "0755"
  /bin/config-reloader:
    exists: true
    mode: "0755"
  /usr/local/bin/fluentd:
    exists: true
    mode: "0777"
command:
  /usr/local/bin/fluentd --version:
    exit-status: 0
    stdout:
    #- "{{ .fluentd_version }}"
    - 1.9.2
  /usr/local/bundle/bin/fluent-gem list:
    exit-status: 0
    stdout:
    - /^googleauth\ \(0\.9\.0\)/
    - /^fluent-plugin-bigquery\ \(2\.2\.0\)/
    - /^fluent-plugin-cloudwatch-logs\ \(0\.7\.3\)/
    - /^fluent-plugin-concat\ \(2\.3\.0\)/
    - /^fluent-plugin-datadog\ \(0\.11\.0\)/
    - /^fluent-plugin-detect-exceptions\ \(0\.0\.12\)/
    - /^fluent-plugin-elasticsearch\ \(3\.5\.2\)/
    - /^fluent-plugin-google-cloud\ \(0\.7\.26\)/
    - /^fluent-plugin-kafka\ \(0\.9\.6\)/
    - /^fluent-plugin-kinesis\ \(3\.1\.0\)/
    - /^fluent-plugin-kubernetes\ \(0\.3\.1\)/
    - /^fluent-plugin-kubernetes_metadata_filter\ \(2\.4\.1\)/
    - /^fluent-plugin-logentries\ \(0\.2\.10\)/
    - /^fluent-plugin-mail\ \(0\.3\.0\)/
    - /^fluent-plugin-out-http-ext\ \(0\.1\.10\)/
    - /^fluent-plugin-record-modifier\ \(2\.0\.1\)/
    - /^fluent-plugin-record-reformer\ \(0\.9\.1\)/
    - /^fluent-plugin-rewrite-tag-filter\ \(2\.2\.0\)/
    - /^fluent-plugin-route\ \(1\.0\.0\)/
    - /^fluent-plugin-s3\ \(1\.1\.11\)/
    - /^fluent-plugin-scribe\ \(1\.0\.0\)/
    - /^fluent-plugin-systemd\ \(1\.0\.2\)/
    - /^fluent-plugin-secure-forward\ \(0\.4\.5\)/
