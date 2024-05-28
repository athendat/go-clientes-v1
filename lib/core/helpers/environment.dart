class Environment {
  static const String host = "api.go-go-go.app";
  static const String apigogo = "https://$host/graphql";

  static const String paseurl = "https://$host/api_023";

  static const String apiKey =
      "26f2ca5a605b8f2437c7b865567640b737c9552bafffea3031229efef4832baf";

  static const String apiKeyBalanc =
      "26f2ca5a605b8f2437c7b865567640b737c9552bafffea3031229efef4832baf";

  //GoGoGO api
  static const String mapboxkey =
      "sk.eyJ1IjoiYW5kaWVsZGV2IiwiYSI6ImNsanJhYXF4czBncTQzanM1NHA2bWMxenMifQ.2juV5bVXicruUB7URUM_TA";
  static const String apiclientloguingogo = "$paseurl/auth/clients/sign-in";
  static const String apisignupgogo = '$paseurl/auth/clients/sign-up';
  static const String activateusergogo = '$paseurl/auth/clients/confirm';
  static const String forgotpassclientgogogo =
      "$paseurl/auth/clients/forgot-password";
  static const String recoverpassclientgogo =
      "$paseurl/auth/clients/recover-password";
  static const String uploadcloudinary = "$paseurl/cloudinary/upload/";

  //info Contact--------------------------------
  static const String numerphone = '+5350952149';
  static const String email = 'info@go-go-go.app';
  static const String telegram = 'contacto_gogogo';
  //-----------------------MAPBOX API REQUEST-------------------------------------------
  static const String getrutepolyline =
      "https://api.mapbox.com/directions/v5/mapbox/driving/";
  //graphql peticiones---------------------------------
  static const String findAllRequestClient = """
query FindAllRequestsByClient(
 \$offset: Int
 \$limit: Int
 \$sort: String
 \$order: Order
 \$search: String
) {
 findAllRequestsByClient(
  offset: \$offset
  limit: \$limit
  sort: \$sort
  order: \$order
  search: \$search
 ) {
  ok
  message

  requests {
   id
   clientId
   pickUpDate
   paymentStatus
   status
   tracking
   createdAt
   weight
   volume
   isImo
   isRefrigerated
   origin {
    type
    coordinates
   }
   destiny {
    type
    coordinates
   }
   distance
  }
 }
}""";
  static const String getsolicitudesByClientid = """
query FindRequestByIdByClient(
 \$id: String!
) {
 findRequestByIdByClient(
  id: \$id
 ) {
  ok
  message

  request {  
   id
   clientId
   pickUpDate
   paymentStatus
   status
   tracking
   createdAt
   weight
   volume
   isImo
	 packages
   obs
	 title
   weight
   volume
	 value
   isRefrigerated
	 originAddress
	 destinyAddress
   realPrice
   origin {
    type
    coordinates
   }
   destiny {
    type
    coordinates
   }
   distance
  }
 }
}

""";

  static const String createSolicitud = """
mutation CreateRequest(\$createRequestInput: CreateRequestInput!) {
 createRequest(createRequestInput: \$createRequestInput) {
  ok
  message

  request {
   id
   clientId
   pickUpDate
	 title	
   paymentStatus
   status
   tracking
   createdAt
   weight
   volume	
   isImo
   isRefrigerated
   origin {
    type
    coordinates
   }
   destiny {
    type
    coordinates
   }
   distance
	 originAddress
	 destinyAddress
  }
 }
} 
""";

  static const String updateSolicitud = """
mutation UpdateRequest(\$updateRequestInput: UpdateRequestInput!) {
updateRequest(updateRequestInput: \$updateRequestInput) {
  ok
  message

  request {
   id
   clientId
   pickUpDate
	 title	
   paymentStatus
   status
   tracking
   createdAt
   weight
   volume	
   isImo
   isRefrigerated
   origin {
    type
    coordinates
   }
   destiny {
    type
    coordinates
   }
   distance
	 originAddress
	 destinyAddress
  }
 }
} 
""";

  static const String getrequestByIdclient = """
query FindRequestsByClient(
 \$offset: Int
 \$limit: Int
 \$sort: String
 \$order: Order
 \$search: String
 \$filter: [String!]
) {
 findRequestsByClient(
  offset: \$offset
  limit: \$limit
  sort: \$sort
  order: \$order
  search: \$search
  filter: \$filter
 ) {
  ok
  message

  pagination {
   length
   size
   page
  }

  requests {
   id
   clientId
   pickUpDate
   paymentStatus
   status
   tracking
   createdAt
   weight
   volume
   isImo
   isRefrigerated
   origin {
    type
    coordinates
   }
   destiny {
    type
    coordinates
   }
   distance
  }
 }
}
""";
  static const String getprofile = """
query GetProfileData {
        getProfileData {
            ok
            message

            client {
id
name
lastname1
lastname2
email
idNumber
phone
gender
avatar
address
country
city
state
town
zip
birthday
age
fullname
}
        }
    }
""";

  static const String updateProfile = """
    mutation UpdateClient(\$updateClientInput: UpdateClientInput!) {
        updateClient(updateClientInput: \$updateClientInput) {
            ok
            message
        }
    }
""";

  static const String update_pasword =
      """  mutation UpdatePassword(\$updatePasswordInput: UpdatePasswordInput!) {
        updatePassword(updatePasswordInput: \$updatePasswordInput) {
            ok
            message
        }
    }""";

  static const String updateImageProfileClient = """
mutation UpdateClientAvatar(\$updateEntityImageInput: UpdateEntityImageInput!) {
        updateClientAvatar(updateEntityImageInput: \$updateEntityImageInput) {
            ok,
            message
        }
    }
""";

  static const String updateImageProfileUser = """
mutation {
    updateAvatar(
        updateEntityImageInput: {
            id: "identificador del usuario UUID",
            imageUrl: "URL de la Imagen"
        }
    ){
        ok
        message
    }
}
""";

  static const String socketUrl = "https://api.go-go-go.app/";
  static const String requestmarkLista = '''
mutation SetRequestAsReady(\$setRequestStatusInput: SetRequestStatusInput!) {
	setRequestAsReady(setRequestStatusInput: \$setRequestStatusInput) {
		ok
		message

		request {
			id
			clientId
			pickUpDate
			obs
			ready
			readyAt
		}
	}
}

''';

  static const String getfeeupdate = '''
query FindCurrentServiceFee {
 findCurrentServiceFee {
  ok
  message

  serviceFee {
   id
   date
   fee
  }
  
 }
}
''';


static const String findBidsByRequestId= """
query FindBidsByRequestIdClient(
        \$requestId: String!
    ) {
        findBidsByRequestIdClient(
            requestId: \$requestId
        ) {
            ok
            message


            bids {
                id
                no
                merchantId
                merchant {
                    logoUrl
                    name
                    address
                    city
                    state
                    nit
                    phoneNumbers {
                        phoneNumber
                        label
                        stateCode
                    }
                    emails {
                        email
                        label
                    }
                }

                clientId
                client {
                    name
                    lastname1
                    lastname2
                    fullname
                    address
                    city
                    state
                    idNumber
                    phone
                    email
                }

                userId
                user {
                    name
                    lastname1
                    lastname2
                    fullname
                    idNumber
                }

                requestId
                

                price
                pickUpDate

                status
                changeStatusAt

                rejectedAt
                rejected
                rejectObs

                canceledAt
                canceled
                cancelObs

                acceptedAt
                accepted
            }
        }
    }
""";


static const String rejectBid = """
    mutation RejectBid(\$acceptCancelRejectBidInput: AcceptCancelRejectBidInput!) {
      rejectBid(
        acceptCancelRejectBidInput: \$acceptCancelRejectBidInput
      ) {
        ok
        message
      }
    }
""";


static const String acceptBid = """
    mutation AcceptBid(\$acceptCancelRejectBidInput: AcceptCancelRejectBidInput!) {
      acceptBid(
        acceptCancelRejectBidInput: \$acceptCancelRejectBidInput
      ) {
        ok
        message
      }
    }
""";

}
