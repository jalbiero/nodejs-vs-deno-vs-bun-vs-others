#!/usr/bin/env python

# Copyright (C) 2023 Javier Albiero (jalbiero)
# Distributed under the MIT License (see the accompanying LICENSE file
# or go to http://opensource.org/licenses/MIT).

from os import listdir, path
import sys
from typing import Generator
import pandas as pd


def csv_provider(dir: str) -> Generator[str, None, None]:
    file: str
    for file in listdir(dir):
        fullname: str = path.join(dir, file)
        if path.isfile(fullname):
            file_ext: str = path.splitext(file)[1]
            if file_ext in [".csv", ".CSV"]:
                yield fullname


def process_csv(csv_dir: str) -> None:
    for csv_file_name in csv_provider(csv_dir):
        print("\n=================================>>")
        print(f"Stats for: {csv_file_name}")
        
        df = pd.read_csv(csv_file_name)[["label", "elapsed"]]
        print(df.groupby(['label']).describe())
        

def main() -> None:
    if len(sys.argv) < 2:
        print(f"Syntax: {sys.argv[0]} DIRECTORY_WHERE_CSVs_ARE_LOCATED")
        sys.exit(1)
    else:
        process_csv(sys.argv[1])


if __name__ == "__main__":
    main()
