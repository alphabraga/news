<?php return array(
    'root' => array(
        'name' => '__root__',
        'pretty_version' => '1.0.0+no-version-set',
        'version' => '1.0.0.0',
        'reference' => NULL,
        'type' => 'library',
        'install_path' => __DIR__ . '/../../',
        'aliases' => array(),
        'dev' => true,
    ),
    'versions' => array(
        '__root__' => array(
            'pretty_version' => '1.0.0+no-version-set',
            'version' => '1.0.0.0',
            'reference' => NULL,
            'type' => 'library',
            'install_path' => __DIR__ . '/../../',
            'aliases' => array(),
            'dev_requirement' => false,
        ),
        'deployer/deployer' => array(
            'pretty_version' => 'v7.3.1',
            'version' => '7.3.1.0',
            'reference' => 'c5c5e79d4e57445918ed24a9cdd3d85b0f261de3',
            'type' => 'library',
            'install_path' => __DIR__ . '/../deployer/deployer',
            'aliases' => array(),
            'dev_requirement' => true,
        ),
    ),
);
