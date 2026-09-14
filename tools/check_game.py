#!/usr/bin/env python3
"""Build and exercise the sketch using an installed Processing 4 macOS app."""
import argparse
from pathlib import Path
import subprocess
import tempfile

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--processing', type=Path, default=Path('/Applications/Processing.app'))
parser.add_argument('--libraries', type=Path, default=Path.home() / 'Documents/Processing/libraries')
parser.add_argument('--capture', action='store_true', help='save the README gameplay screenshots instead of running assertions')
args = parser.parse_args()
repo = Path(__file__).resolve().parents[1]
contents = args.processing.expanduser().resolve() / 'Contents'
legacy = contents / 'Java'
if legacy.is_dir():
    resources = legacy
    java_home = next((contents / 'PlugIns').glob('*/Contents/Home'))
    commander = [str(java_home / 'bin/java'), '-cp', f'{legacy}/*:{legacy}/modes/java/mode/*', 'processing.mode.java.Commander']
else:
    resources = contents / 'app/resources'
    java_home = resources / 'jdk'
    commander = [str(contents / 'MacOS/Processing'), 'cli']

jars = list((resources / 'core/library').glob('*.jar'))
for name in ('controlP5', 'box2d_processing', 'minim'):
    library = args.libraries.expanduser() / name / 'library'
    found = list(library.glob('*.jar'))
    if not found:
        parser.error(f'Missing {name}: install it in {args.libraries}')
    jars.extend(found)

with tempfile.TemporaryDirectory(prefix='dungeon-explorer-') as temporary:
    build = Path(temporary) / 'build'
    subprocess.run([*commander, f'--sketch={repo}', f'--output={build}', '--force', '--build'], check=True)
    classpath = ':'.join(map(str, [build, *jars]))
    test = 'CaptureScreenshots' if args.capture else 'GameplayRegression'
    subprocess.run([str(java_home / 'bin/javac'), '-cp', classpath, '-d', str(build), str(repo / 'tests' / f'{test}.java')], check=True)
    subprocess.run([str(java_home / 'bin/java'), '-ea', '-cp', classpath, test, f'--sketch-path={repo}'], cwd=repo, check=True, timeout=90)
