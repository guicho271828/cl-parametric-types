BEGIN{
    print "Documentation for "ARGV[1]
    print "=================="
}

/^;{3}/{
    print "## "substr($0,4)"\n"
}
/^;{4}/{
    print "### "substr($0,5)"\n"
}
/^;{5}/{
    print "#### "substr($0,6)"\n"
}

/#\|/,/\|#/{
    if($0 ~ /#\|/ || $0 ~ /\|#/){
        print "\n"
    }else{
        print
    }
}

/defun/{
    name=$2
    $1=""
    $2=""
    print "* Function "name" "$0"\n"
}

/defmacro/{
    name=$2
    $1=""
    $2=""
    print "* Macro "name" "$0"\n"
}

/^ *"/,/.*"$/{
    # if($0 ~ /^ *"/){
    #     print "\n"
    # }
    print
    if ($0 ~ /.*"$/){
        print "\n"
    }
}
