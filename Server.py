import socket
s=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
s.bind(('0.0.0.0',30002))
waitinglist = set()
while(True):
	dataclient,addressclient = s.recvfrom(1024)
	print dataclient
	if(dataclient=='connect'):
		print 'Recieved request'
		waitinglist.add(addressclient)
		if len(waitinglist)<2:
			continue
		for address in waitinglist:
			if (address!=addressclient):
				s.sendto('Please confirm'+'\0', address)
		s.settimeout(0.5)
		datajoin = None
		try:
			datajoin,addressjoin = s.recvfrom(1024)
		except:
			pass
		s.settimeout(None)
		if(datajoin=='confirm'):
			print 'Transferring IP'
			#s.sendto('You are player 1'+'\0')
			#s.sendto('Prepare for IP transfer'+'\0', addressjoin)
			s.sendto('Prepare for IP transfer'+'\0', addressclient)
			s.sendto(str(addressjoin[0])+'\0',addressclient)
			print 'Sent '+str(addressjoin[0])+' to ' +str(addressclient)
			s.sendto(str(addressjoin[1])+'\0',addressclient)
			print 'Sent '+str(addressjoin[1])+' to ' +str(addressclient)
			s.sendto(str(addressclient[0])+'\0',addressjoin)
			print 'Sent '+str(addressclient[0])+ ' to ' +str(addressjoin)
			s.sendto(str(addressclient[1])+'\0',addressjoin)
			print ('Sent '+str(addressclient[1])+' to '+str(addressjoin))
			waitinglist.discard(addressclient)
			waitinglist.discard(addressjoin)