#!/usr/bin/env python

import os
import re
import argparse
import sys


ansi_template = "\033[38;2;{r};{g};{b}m{cont}\033[0m"
pattern = re.compile(r"\[color=(#[0-9a-fA-F]{6})\](.*?)\[\/color\]")


def hex_to_rgb(hex: str) -> tuple[int, int, int]:
    hex = hex.lstrip("#")
    rs, gs, bs = hex[0:2], hex[2:4], hex[4:6]
    return int(rs, base=16), int(gs, base=16), int(bs, base=16)


def replace(bbs_code_match: re.Match[str]):
    hex = bbs_code_match[1]
    cont = bbs_code_match[2]
    r, g, b = hex_to_rgb(hex)
    return ansi_template.format(r=r, g=g, b=b, cont=cont)


def main(input_str: str) -> str:
    tmp = input_str
    tmp = tmp.replace("[size=9px][font=monospace]", "")
    tmp = tmp.replace("\n\n[/font][/size]", "")
    tmp = re.sub(pattern, repl=replace, string=tmp, count=99999)

    return tmp


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        prog="bbs2ansi.py",
        description="Converts bbs code from https://asciiart.club/ to ANSI escape codes for terminal use.",
    )

    parser.add_argument("--stdin", action="store_true", help="stdin input.")
    parser.add_argument("-o", help="Output filename.")

    args = parser.parse_args()

    input_str = None

    if args.stdin:
        input_str = sys.stdin.read()

        print("this inpuy")

        print(input_str)

        print("this input_str")

        if not isinstance(input_str, str):
            raise ValueError("stdin is invalid.")
    else:
        raise ValueError("You must specify at least 1 input source.")

    output_str = main(input_str)

    if isinstance(args.o, str) and os.path.isfile(args.o):
        with open(args.o, "w") as f:
            _ = f.write(output_str)
    else:
        sys.stdout.write(output_str)
