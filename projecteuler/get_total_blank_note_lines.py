#!/usr/bin/env python
# -*- coding: utf-8 -*_

__author__ = 'zhuwei'

import os
import sys


def get_files(path):
    if os.path.isfile(path):
        return [path]
    files = []
    entries = os.listdir(path)
    for entry in entries:
        path1 = path + '/' + entry
        if os.path.isdir(path1):
            files += get_files(path1)
        elif os.path.isfile(path1):
            files.append(path1)
        else:
            pass
    return files


def get_total_blank_note_lines(files):
    total, blank, note = 0, 0, 0
    for filename in files:
        for line in open(filename, 'rb'):
            total += 1
            line = line.strip()
            if line == '':
                blank += 1
            elif line[0] == '#':
                if len(line) > 1 and line[1] == '!':
                    pass
                else:
                    note += 1
            else:
                pass
    return total, blank, note

if __name__ == '__main__':
    # files = get_files("get_total_blank_note_lines.py")
    if len(sys.argv) == 1:
        path = "./"
    elif len(sys.argv) == 2:
        path = sys.argv[1]
    else:
        raise Exception("too many arguments")
    files = get_files(path)
    print "files: {0}".format(len(files))
    total, blank, note = get_total_blank_note_lines(files)
    print "lines: {0}".format(total)
    print "blank lines: {0}".format(blank)
    print "note lines: {0}".format(note)