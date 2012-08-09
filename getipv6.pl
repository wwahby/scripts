use Clipboard;

$result = `ipconfig`;

#print $result;

if ($result =~ m/\s+Link-local IPv6 Address( \.)+\s+: (\S+)/)
{
	$ipv6 = $2;

	print "ipv6: $ipv6\n";
	Clipboard->copy($ipv6)
}


