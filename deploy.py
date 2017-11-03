from os import listdir
from os.path import isfile, join, isdir, exists
from subprocess import call
import urllib2

ROOT = '/n/groups/lsp/o2'
ARTEFACT_ROOT = join(ROOT, 'artefacts')
MODULE_ROOT = join(ROOT, 'modulefiles')
APP_ROOT = join(ROOT, 'apps')
GIT_API_URLS = {
    'ashlar': 'https://api.github.com/repos/sorgerlab/ashlar',
    'omero-scripts': 'https://api.github.com/repos/sorgerlab/OMERO_scripts'
}
GIT_URLS = {
    'ashlar': 'git+https://github.com/sorgerlab/ashlar.git',
    'omero-scripts': 'git+https://github.com/sorgerlab/OMERO_scripts.git'
}

def check_tag(module, version):
    # Ensure this tag exists
    if module in GIT_API_URLS:
        tag_url = '%s/git/refs/tags/v%s' % (GIT_API_URLS.get(module), version)

        try:
            urllib2.urlopen(tag_url)
        except urllib2.HTTPError, e:
            print 'Module {} version {} is not tagged'.format(module, version)
            return False

        return True


def check_artefact(path):
    # Ensure the artefact exists
    return exists(path) and isfile(path)


def check_app_not_installed(module, version):
    return not exists(join(APP_ROOT, module, version))


def install_ashlar(version):
    ''' Deploy ASHLAR '''

    path = join(APP_ROOT, 'ashlar', version)
    git_url = '{}@v{}'.format(GIT_URLS.get(module), version)

    # Run the ashlar installer
    call(['bash', 'install_ashlar.sh', path, git_url])


def install_omero_scripts(version):
    ''' Deploy omero-scripts '''

    path = join(APP_ROOT, 'omero-scripts', version)
    git_url = '{}@v{}'.format(GIT_URLS.get(module), version)

    # Run the omero-scripts installer
    call(['bash', 'install_omero-scripts.sh', path, git_url])


def install_stitcher(version):
    ''' Deploy sticher '''

    release = join(ARTEFACT_ROOT, 'sticher-{}.zip'.format(version))
    parent_path = join(APP_ROOT, 'stitcher')
    path = join(parent_path, version)

    # Make directory
    call(['mkdir', '-p', parent_path])

    # Unzip sticher into parent
    call(['unzip', '-d', parent_path, release])

    # Rename unzipped directory to version number
    call(['mv', join(parent_path, 'sticher-{}'.format(version)), path])

    # Symlink the sticher binary to stitcher
    call(['ln', '-s', join(path, 'bin', 'sticher'),
          join(path, 'bin', 'stitcher')])


def install(module, version):

    # Check if app is already installed
    if check_app_not_installed(module, version):
        if module == 'omero-scripts':
            if check_tag(module, version):
                print 'Installing {} {}'.format(module, version)
                install_omero_scripts(version)
            else:
                print 'Skipping {} {} (Missing tag)'.format(module, version)
        elif module == 'ashlar':
            if check_tag(module, version):
                print 'Installing {} {}'.format(module, version)
                install_ashlar(version)
            else:
                print 'Skipping {} {} (Missing tag)'.format(module, version)
        # Note that the module is called `stitcher`, but from this point on it is
        # referred to as `sticher` as this is what has been distributed as
        elif module == 'stitcher':
            if check_artefact(join(ARTEFACT_ROOT,
                                   'sticher-{}.zip'.format(version))):
                print 'Installing {} {}'.format(module, version)
                install_stitcher(version)
            else:
                print 'Skipping {} {} (Missing artefact)'.format(module,
                                                                 version)
    else:
        print 'Skipping {} {} (Installed)'.format(module, version)


path = 'modulefiles/'

for d in listdir(path):
    if isdir(join(path, d)):
        for f in listdir(join(path, d)):
            if isfile(join(path, d, f)):
                module = d
                version = f.split('.lua')[0]
                print '---', module, version, '---'
                install(module, version)
