import setuptools

with open("README.md", "r", encoding="utf-8") as fh:
    long_description = fh.read()

setuptools.setup(
    name="test-infra", # Replace with your own username
    version="0.0.1",
    author="Anchore Inc.",
    author_email="dev@anchore.com",
    description="Anchore CI/Test Harness",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/anchore/test-infra",
    packages=setuptools.find_packages(),
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    python_requires='>=3.6',
    scripts=[
        'anchore-ci/ci_harness',
        'anchore-ci/common_tasks',
        'anchore-ci/release_tasks',
        'anchore-ci/utils'
    ],
)
