<?php

namespace Deployer;

require 'recipe/codeigniter.php';

set('repository', 'git@github.com:alphabraga/news');
      
host('www.thundertech.com.br')
->set('labels', ['stage' => 'testing'])
->set('remote_user', 'root')
->set('deploy_path', '/project/news');

// Hooks
after('deploy:failed', 'deploy:unlock');

desc('Run actions before deploy on production');
task('deploy:done', function () {
    writeln('Cleaning cache and killing sessions...');
    /* run("rm -rf /project/precopratico/shared/system/precoPratico2/cache/*");
    require 'application/config/development/database.php';

    $connection = mysqli_connect($config['host'], $config['username'], $config['password'], $config['database']);
    $raw_password = 'Teste123@';
    $password = password_hash($raw_password, PASSWORD_DEFAULT);
    $result = mysqli_query($connection, "UPDATE adm_usuarios set senha = '{$password}' where email in ('adm@pp.com', 'le@pp.com')");

    if ($result) {
        writeln('Users adm@pp.com and le@pp.com  set to {$raw_password}');
    } else {
        writeln('Password update error');
    }*/
})->select('stage=testing');
after('deploy', 'deploy:done');