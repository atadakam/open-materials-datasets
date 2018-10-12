#!/usr/bin/env python
# -*- coding: utf-8 -*-

from collections import OrderedDict

import setuptools

with open('README.rst', 'rt', encoding='utf8') as f:
    readme = f.read()

name = "open-materials-datasets"
version = "0.1"
release = "0.1.0"

setuptools.setup(
    name=name,
    author="James K. Glasbrenner",
    author_email="jglasbr2@gmu.edu",
    license="MIT",
    version=release,
    project_urls=OrderedDict((("Repo", ""), )),
    description=(""),
    long_description=readme,
    python_requires=">=3.7",
    packages=setuptools.find_packages("src/python"),
    package_dir={"": "src/python"},
    package_data={"projtool": "templates"},
    include_package_data=True,
    install_requires=[
        "jupyter",
        "jupyterlab",
        "numpy",
        "pandas",
        "pymatgen",
    ],
    extras_require={},
    entry_points="""
    [console_scripts]
    projtool=projtool.cli:cli
    """,
)
