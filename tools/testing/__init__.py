# -*- coding: utf-8 -*-
#!/usr/bin/env python -W ignore::PendingDeprecationWarning
#!/usr/bin/env python -W ignore::DeprecationWarning
import string


def compareIgnoreSpace(s1, s2):

    return ' '.join(s1.split()) == ' '.join(s2.split())
