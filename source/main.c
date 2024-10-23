#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>
#include <string.h>

typedef struct addrinfo addrinfo; 

int main()
{
	addrinfo hints;
	addrinfo* server_info;
	int status;

	memset(&hints, 0, sizeof hints); // make sure the struct is empty
	hints.ai_family = AF_UNSPEC;     // don't care IPv4 or IPv6
	hints.ai_socktype = SOCK_STREAM; // TCP stream sockets

	status = getaddrinfo("www.example.net", "3490", &hints, &server_info);

	freeaddrinfo(server_info);
	return 0;
}