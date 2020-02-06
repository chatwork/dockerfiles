provisioners:
  textReplace:
    Dockerfile:
      from: "ARG NR_VERSION={{ .newrelicphpagent.previousVersion }}"
      to: "ARG NR_VERSION={{ .newrelicphpagent.version }}"

dependencies:
  newrelicphpagent:
    releasesFrom:
      exec:
        command: sh
        args:
        - -c
        - |
          curl -s 'https://download.newrelic.com/php_agent/release/' | sed -n 's/.*>newrelic-php5-\(.*\).linux.tar.gz.*/\1/p'