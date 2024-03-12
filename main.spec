# -*- mode: python ; coding: utf-8 -*-

import glob

block_cipher = None

# Function to search for files using wildcards and prepare them for datas
def find_datas(pattern, source_folder, target_folder):
    return [(filename, target_folder) for filename in glob.glob(source_folder + '/' + pattern)]

# Collecting all .qml and .png files using wildcards
datas = find_datas('*.*', 'ui', 'ui') + find_datas('*.*', 'assets', 'assets')

a = Analysis(['main.py'],
             pathex=[],
             binaries=[],
             datas=datas,
             hiddenimports=[],
             hookspath=['.'],
             hooksconfig={},
             runtime_hooks=[],
             excludes=[],
             noarchive=False,
             )
pyz = PYZ(a.pure, a.zipped_data,
             cipher=block_cipher)
exe = EXE(pyz,
          a.scripts,
          a.binaries,
          a.zipfiles,
          a.datas,
          [],
          name='Tohooter',
          debug=False,
          bootloader_ignore_signals=False,
          strip=False,
          upx=True,
          upx_exclude=[],
          runtime_tmpdir=None,
          console=False,
          disable_windowed_traceback=False,
          argv_emulation=False,
          target_arch=None,
          codesign_identity=None,
          entitlements_file=None,
          )
