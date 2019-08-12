**Table of Contents**

# airflow
This cannot build on Windows, since the package: **python-daemon** <br>
is for Unix

```
(airflow) PS E:\Tools\Tools\airflow> python $AIRFLOW_SCRIPT
C:\Users\trsl\.conda\envs\airflow\lib\site-packages\airflow\config_templates\airflow_local_settings.py:65: DeprecationWarning: The elasticsearch_host option in [elasticsearch] has been renamed to host - the old setting has been used, but please update your config.
  ELASTICSEARCH_HOST = conf.get('elasticsearch', 'HOST')
C:\Users\trsl\.conda\envs\airflow\lib\site-packages\airflow\config_templates\airflow_local_settings.py:67: DeprecationWarning: The elasticsearch_log_id_template option in [elasticsearch] has been renamed to log_id_template - the old setting has been used, but please update your config.
  ELASTICSEARCH_LOG_ID_TEMPLATE = conf.get('elasticsearch', 'LOG_ID_TEMPLATE')
C:\Users\trsl\.conda\envs\airflow\lib\site-packages\airflow\config_templates\airflow_local_settings.py:69: DeprecationWarning: The elasticsearch_end_of_log_mark option in [elasticsearch] has been renamed to end_of_log_mark - the old setting has been used, but please update your config.
  ELASTICSEARCH_END_OF_LOG_MARK = conf.get('elasticsearch', 'END_OF_LOG_MARK')
WARNING:root:OSError while attempting to symlink the latest log directory
Traceback (most recent call last):
  File "C:\Users\trsl\.conda\envs\airflow\Scripts\airflow", line 22, in <module>
    from airflow.bin.cli import CLIFactory
  File "C:\Users\trsl\.conda\envs\airflow\lib\site-packages\airflow\bin\cli.py", line 41, in <module>
    import daemon
  File "C:\Users\trsl\.conda\envs\airflow\lib\site-packages\daemon\__init__.py", line 42, in <module>
    from .daemon import DaemonContext
  File "C:\Users\trsl\.conda\envs\airflow\lib\site-packages\daemon\daemon.py", line 25, in <module>
    import pwd
ModuleNotFoundError: No module named 'pwd'
```


<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>
