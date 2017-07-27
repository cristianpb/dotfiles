#!/usr/bin/env python
"""
    Copyright 2011 by Brian C. Lane
"""
import sys
import email

raw_msg = sys.stdin.read()
msg = email.message_from_string(raw_msg)
date = msg.get('Date', None)
if date:
    from email.utils import mktime_tz, parsedate_tz, formatdate

    try:
        # Convert to local TZ
        tz_tuple = parsedate_tz(date)
        epoch_time = mktime_tz(tz_tuple)
        msg.add_header('Local-Date', formatdate( epoch_time, localtime=True ))

        #from cStringIO import StringIO
        try:
            from StringIO import StringIO
        except ImportError:
            from io import StringIO
        from email.generator import Generator
        fp = StringIO()
        g = Generator(fp, mangle_from_=False, maxheaderlen=200)
        g.flatten(msg)
        sys.stdout.write(fp.getvalue())
    except:
        import traceback
        print(traceback.format_exc())
        sys.stdout.write(raw_msg)
else:
    # just write it out
    sys.stdout.write(raw_msg)
