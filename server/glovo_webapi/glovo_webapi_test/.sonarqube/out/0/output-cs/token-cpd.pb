í
ß/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/ApiHelpers/AuthorizeAttribute.cs
	namespace 	
glovo_webapi
 
. 
Helpers 
{		 
[

 
AttributeUsage

 
(

 
AttributeTargets

 $
.

$ %
Class

% *
|

+ ,
AttributeTargets

- =
.

= >
Method

> D
)

D E
]

E F
public 

class 
AuthorizeAttribute #
:$ %
	Attribute& /
,/ 0 
IAuthorizationFilter1 E
{ 
public 
string 
Roles 
{ 
get !
;! "
set# &
;& '
}( )
public 
void 
OnAuthorization #
(# $&
AuthorizationFilterContext$ >
context? F
)F G
{ 	
var 
user 
= 
( 
User 
) 
context %
.% &
HttpContext& 1
.1 2
Items2 7
[7 8
$str8 >
]> ?
;? @
if 
( 
user 
== 
null 
) 
{ 
context 
. 
Result 
=  
new! $

JsonResult% /
(/ 0
new0 3
{4 5
message5 <
== >
$str? M
}M N
)N O
{ 

StatusCode 
=  !
StatusCodes" -
.- .!
Status401Unauthorized. C
}C D
;D E
return 
; 
} 
if 
( 
Roles 
!= 
null 
) 
{ 
var 
	roleArray 
= 
Roles  %
.% &
Split& +
(+ ,
$char, /
)/ 0
. 
Select 
( 
x 
=>  
x! "
." #
Trim# '
(' (
)( )
)) *
. 
Where 
( 
x 
=> 
!  !
string! '
.' (
IsNullOrWhiteSpace( :
(: ;
x; <
)< =
)= >
. 
ToArray 
( 
) 
; 
if   
(   
	roleArray   
.   
Length   $
>  % &
$num  ' (
&&  ) +
	roleArray  , 5
.  5 6
All  6 9
(  9 :
x  : ;
=>  < >
x  ? @
!=  A C
user  D H
.  H I
Role  I M
.  M N
ToString  N V
(  V W
)  W X
)  X Y
)  Y Z
{!! 
context## 
.## 
Result## "
=### $
new##% (

JsonResult##) 3
(##3 4
new##4 7
{##8 9
message##9 @
=##A B
$str##C Q
}##Q R
)##R S
{$$ 

StatusCode$$ #
=$$$ %
StatusCodes$$& 1
.$$1 2!
Status401Unauthorized$$2 G
}$$G H
;$$H I
}%% 
}&& 
}'' 	
}(( 
})) –
¢/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/ApiHelpers/JwtMiddleware.cs
	namespace

 	
glovo_webapi


 
.

 
Helpers

 
{ 
public 

class 
JwtMiddleware 
{ 
private 
readonly 
RequestDelegate (
_next) .
;. /
private 
readonly 
IOptions !
<! "
AppConfiguration" 2
>2 3
_configuration4 B
;B C
public 
JwtMiddleware 
( 
RequestDelegate ,
next- 1
,1 2
IOptions3 ;
<; <
AppConfiguration< L
>L M
configurationN [
)[ \
{ 	
_next 
= 
next 
; 
_configuration 
= 
configuration *
;* +
} 	
public 
async 
Task 
Invoke  
(  !
HttpContext! ,
context- 4
,4 5
IUsersService6 C
userServiceD O
)O P
{ 	
var 
tokenStr 
= 
context "
." #
Request# *
.* +
Headers+ 2
[2 3
$str3 B
]B C
.C D
FirstOrDefaultD R
(R S
)S T
?T U
.U V
SplitV [
([ \
$str\ _
)_ `
.` a
Lasta e
(e f
)f g
;g h
if 
( 
tokenStr 
!= 
null  
)  !
AttachUserToContext #
(# $
context$ +
,+ ,
userService- 8
,8 9
tokenStr: B
)B C
;C D
await 
_next 
( 
context 
)  
;  !
} 	
private!! 
void!! 
AttachUserToContext!! (
(!!( )
HttpContext!!) 4
context!!5 <
,!!< =
IUsersService!!> K
userService!!L W
,!!W X
string!!Y _
tokenStr!!` h
)!!h i
{"" 	!
TokenCreatorValidator## !!
tokenCreatorValidator##" 7
=##8 9
new##: =!
TokenCreatorValidator##> S
(##S T
_configuration##T b
.##b c
Value##c h
.##h i
Secret##i o
)##o p
;##p q
try$$ 
{%% !
TokenValidationParams&& %!
tokenValidationParams&&& ;
=&&< =!
tokenCreatorValidator&&> S
.&&S T
ValidateToken&&T a
(&&a b
tokenStr&&b j
)&&j k
;&&k l
User'' 
	tokenUser'' 
=''  
userService''! ,
.'', -
GetById''- 4
(''4 5!
tokenValidationParams''5 J
.''J K
UserId''K Q
)''Q R
;''R S
if(( 
((( 
Encoding(( 
.(( 
Default(( $
.(($ %
	GetString((% .
(((. /
	tokenUser((/ 8
.((8 9
AuthSalt((9 A
)((A B
==((C E
Encoding)) 
.)) 
Default)) $
.))$ %
	GetString))% .
()). /!
tokenValidationParams))/ D
.))D E
	SaltBytes))E N
)))N O
)))O P
{** 
context++ 
.++ 
Items++ !
[++! "
$str++" (
]++( )
=++* +
	tokenUser++, 5
;++5 6
},, 
}-- 
catch.. 
{// 
}22 
}33 	
}44 
}55 ú;
≠/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Controllers/Orders/OrdersController.cs
	namespace 	
glovo_webapi
 
. 
Controllers "
." #
Orders# )
{ 
[ 
ApiController 
] 
[ 
Route 

(
 
$str 
) 
] 
public 

class 
OrdersController !
:" #
ControllerBase$ 2
{ 
private 
readonly 
IOrdersService '
_service( 0
;0 1
private 
readonly 
IMapper  
_mapper! (
;( )
public 
OrdersController 
(  
IOrdersService  .
service/ 6
,6 7
IMapper8 ?
mapper@ F
)F G
{ 	
_service 
= 
service 
; 
_mapper 
= 
mapper 
; 
} 	
[ 	
HttpGet	 
] 
[ 	
	Authorize	 
( 
Roles 
= 
$str (
)( )
]) *
public 
ActionResult 
< 
IEnumerable '
<' (
GetOrderModel( 5
>5 6
>6 7
GetAllOrders8 D
(D E
)E F
{ 	
IEnumerable   
<   
Order   
>   
orders   %
=  & '
_service  ( 0
.  0 1
GetAllOrders  1 =
(  = >
)  > ?
;  ? @
return!! 
Ok!! 
(!! 
_mapper!! 
.!! 
Map!! !
<!!! "
IEnumerable!!" -
<!!- .
GetOrderModel!!. ;
>!!; <
>!!< =
(!!= >
orders!!> D
)!!D E
)!!E F
;!!F G
}"" 	
[%% 	
HttpGet%%	 
(%% 
$str%% 
)%% 
]%% 
[&& 	
	Authorize&&	 
(&& 
Roles&& 
=&& 
$str&& 1
)&&1 2
]&&2 3
public'' 
ActionResult'' 
<'' 
GetOrderModel'' )
>'') *
GetOrderById''+ 7
(''7 8
int''8 ;
orderId''< C
)''C D
{(( 	
Order)) 

foundOrder)) 
;)) 
try** 
{** 

foundOrder++ 
=++ 
_service++ %
.++% &
GetOrderById++& 2
(++2 3
orderId++3 :
)++: ;
;++; <
},, 
catch,, 
(,, 
RequestException,, $
),,$ %
{,,& '
return-- 
NotFound-- 
(--  
new--  #
{--$ %
message--% ,
=--- .
$str--/ C
}--C D
)--D E
;--E F
}.. 
User11 

loggedUser11 
=11 
(11 
User11 #
)11# $
HttpContext11$ /
.11/ 0
Items110 5
[115 6
$str116 <
]11< =
;11= >
if22 
(22 

loggedUser22 
==22 
null22 !
)22! "
return33 
NotFound33 
(33  
new33  #
{33$ %
message33% ,
=33- .
$str33/ B
}33B C
)33C D
;33D E
if44 
(44 

loggedUser44 
.44 
Role44 
==44  "
UserRole44# +
.44+ ,
Regular44, 3
&&444 6

foundOrder447 A
.44A B
UserId44B H
!=44I K

loggedUser44L V
.44V W
Id44W Y
)44Y Z
return55 
Unauthorized55 #
(55# $
new55$ '
{55( )
message55) 0
=551 2
$str553 A
}55A B
)55B C
;55C D
return77 
Ok77 
(77 
_mapper77 
.77 
Map77 !
<77! "
GetOrderModel77" /
>77/ 0
(770 1

foundOrder771 ;
)77; <
)77< =
;77= >
}88 	
[;; 	
HttpPost;;	 
];; 
[<< 	
	Authorize<<	 
(<< 
Roles<< 
=<< 
$str<< 1
)<<1 2
]<<2 3
public== 
ActionResult== 
<== 
GetOrderModel== )
>==) *
	PostOrder==+ 4
(==4 5
[==5 6
FromBody==6 >
]==> ?
PostOrderModel==@ N
postOrderModel==O ]
)==] ^
{>> 	
Order?? 
order?? 
=?? 
_mapper?? !
.??! "
Map??" %
<??% &
PostOrderModel??& 4
,??4 5
Order??6 ;
>??; <
(??< =
postOrderModel??= K
)??K L
;??L M
Order@@ 

addedOrder@@ 
;@@ 
tryAA 
{AA 

addedOrderBB 
=BB 
_serviceBB %
.BB% &
AddOrderBB& .
(BB. /
orderBB/ 4
)BB4 5
;BB5 6
}CC 
catchCC 
(CC 
RequestExceptionCC %
exCC& (
)CC( )
{CC* +
ifDD 
(DD 
exDD 
.DD 
CodeDD 
==DD 
OrderExceptionCodesDD 2
.DD2 3
RestaurantNotFoundDD3 E
)DDE F
returnEE 
NotFoundEE #
(EE# $
newEE$ '
{EE' (
messageEE( /
=EE0 1
$strEE2 P
}EEP Q
)EEQ R
;EER S
ifFF 
(FF 
exFF 
.FF 
CodeFF 
==FF 
OrderExceptionCodesFF 2
.FF2 3
ProductNotFoundFF3 B
)FFB C
returnGG 
NotFoundGG #
(GG# $
newGG$ '
{GG' (
messageGG( /
=GG0 1
$strGG2 M
}GGM N
)GGN O
;GGO P
ifHH 
(HH 
exHH 
.HH 
CodeHH 
==HH 
OrderExceptionCodesHH 2
.HH2 3+
ProductNotBelongingToRestaurantHH3 R
)HHR S
returnII 

BadRequestII %
(II% &
newII& )
{II) *
messageII* 1
=II2 3
$strII4 T
}IIT U
)IIU V
;IIV W
ifJJ 
(JJ 
exJJ 
.JJ 
CodeJJ 
==JJ 
OrderExceptionCodesJJ 2
.JJ2 3
BadOrderProductJJ3 B
)JJB C
returnKK 

BadRequestKK %
(KK% &
newKK& )
{KK) *
messageKK* 1
=KK2 3
$strKK4 K
}KKK L
)KKL M
;KKM N
returnLL 

BadRequestLL !
(LL! "
newLL" %
{LL% &
messageLL& -
=LL. /
$strLL0 ?
}LL? @
)LL@ A
;LLA B
}MM 
returnOO 
OkOO 
(OO 
_mapperOO 
.OO 
MapOO !
<OO! "
OrderOO" '
,OO' (
GetOrderModelOO) 6
>OO6 7
(OO7 8

addedOrderOO8 B
)OOB C
)OOC D
;OOD E
}PP 	
}QQ 
}RR ê
π/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Controllers/Orders/OrdersOfRestaurantController.cs
	namespace

 	
glovo_webapi


 
.

 
Controllers

 "
.

" #
Orders

# )
{ 
[ 
ApiController 
] 
[ 
Route 

(
 
$str 
) 
] 
public 

class (
OrdersOfRestaurantController -
:. /
ControllerBase0 >
{ 
private 
readonly 
IOrdersService '
_service( 0
;0 1
private 
readonly 
IMapper  
_mapper! (
;( )
public (
OrdersOfRestaurantController +
(+ ,
IOrdersService, :
service; B
,B C
IMapperD K
mapperL R
)R S
{ 	
_service 
= 
service 
; 
_mapper 
= 
mapper 
; 
} 	
[ 	
HttpGet	 
( 
$str "
)" #
]# $
[ 	
	Authorize	 
( 
Roles 
= 
$str *
)* +
]+ ,
public 
ActionResult 
< 
IEnumerable '
<' (
GetOrderModel( 5
>5 6
>6 7$
GetAllOrdersOfRestaurant8 P
(P Q
intQ T
restIdU [
)[ \
{ 	
IEnumerable 
< 
Order 
> 
restaurantOrders /
;/ 0
try 
{ 
restaurantOrders    
=  ! "
_service  # +
.  + ,$
GetAllOrdersOfRestaurant  , D
(  D E
restId  E K
)  K L
;  L M
}!! 
catch!! 
(!! 
RequestException!! %
)!!% &
{!!' (
return"" 
NotFound"" 
(""  
new""  #
{""# $
message""$ +
="", -
$str"". L
}""L M
)""M N
;""N O
}## 
return%% 
Ok%% 
(%% 
_mapper%% 
.%% 
Map%% !
<%%! "
IEnumerable%%" -
<%%- .
GetOrderModel%%. ;
>%%; <
>%%< =
(%%= >
restaurantOrders%%> N
)%%N O
)%%O P
;%%P Q
}&& 	
}'' 
}(( √
≥/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Controllers/Orders/OrdersOfUserController.cs
	namespace 	
glovo_webapi
 
. 
Controllers "
." #
Orders# )
{ 
[ 
ApiController 
] 
[ 
Route 

(
 
$str 
) 
] 
public 

class "
OrdersOfUserController '
:( )
ControllerBase* 8
{ 
private 
readonly 
IOrdersService '
_service( 0
;0 1
private 
readonly 
IMapper  
_mapper! (
;( )
public "
OrdersOfUserController %
(% &
IOrdersService& 4
service5 <
,< =
IMapper> E
mapperF L
)L M
{ 	
_service 
= 
service 
; 
_mapper 
= 
mapper 
; 
} 	
[ 	
HttpGet	 
( 
$str "
)" #
]# $
[ 	
	Authorize	 
( 
Roles 
= 
$str 1
)1 2
]2 3
public 
ActionResult 
< 
IEnumerable '
<' (
GetOrderModel( 5
>5 6
>6 7
GetAllOrdersOfUser8 J
(J K
intK N
userIdO U
)U V
{ 	
IEnumerable 
< 
Order 
> 

userOrders )
;) *
try   
{   

userOrders!! 
=!! 
_service!! %
.!!% &
GetAllOrdersOfUser!!& 8
(!!8 9
userId!!9 ?
)!!? @
;!!@ A
}"" 
catch"" 
("" 
RequestException"" %
)""% &
{""' (
return## 
NotFound## 
(##  
new##  #
{### $
message##$ +
=##, -
$str##. F
}##F G
)##G H
;##H I
}$$ 
User'' 

loggedUser'' 
='' 
('' 
User'' #
)''# $
HttpContext''$ /
.''/ 0
Items''0 5
[''5 6
$str''6 <
]''< =
;''= >
if(( 
((( 

loggedUser(( 
==(( 
null(( !
)((! "
return)) 
NotFound)) 
())  
new))  #
{))$ %
message))% ,
=))- .
$str))/ B
}))B C
)))C D
;))D E
if** 
(** 

loggedUser** 
.** 
Role** 
==**  "
UserRole**# +
.**+ ,
Regular**, 3
&&**4 6
userId**7 =
!=**> @

loggedUser**A K
.**K L
Id**L N
)**N O
return++ 
Unauthorized++ #
(++# $
new++$ '
{++( )
message++) 0
=++1 2
$str++3 A
}++A B
)++B C
;++C D
return-- 
Ok-- 
(-- 
_mapper-- 
.-- 
Map-- !
<--! "
IEnumerable--" -
<--- .
GetOrderModel--. ;
>--; <
>--< =
(--= >

userOrders--> H
)--H I
)--I J
;--J K
}.. 	
}// 
}00 É
±/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Controllers/Products/ProductsController.cs
	namespace 	
glovo_webapi
 
. 
Controllers "
." #
Products# +
{ 
[ 
ApiController 
] 
[ 
Route 

(
 
$str 
) 
] 
public 

class 
ProductsController #
:$ %
ControllerBase& 4
{ 
private 
readonly 
IProductsService )
_service* 2
;2 3
private 
readonly 
IMapper  
_mapper! (
;( )
public 
ProductsController !
(! "
IProductsService" 2
service3 :
,: ;
IMapper< C
mapperD J
)J K
{ 	
_service 
= 
service 
; 
_mapper 
= 
mapper 
; 
} 	
[ 	
HttpGet	 
] 
public 
ActionResult 
< 
IEnumerable '
<' (
ProductModel( 4
>4 5
>5 6
GetAllProducts7 E
(E F
[F G
	FromQueryG P
]P Q
ProductCategoryQ `
?` a
categoryb j
)j k
{ 	
IEnumerable 
< 
Product 
>  
products! )
;) *
if   
(   
category   
.   
HasValue   !
)  ! "
{  # $
products!! 
=!! 
_service!! #
.!!# $!
GetProductsByCategory!!$ 9
(!!9 :
category!!: B
.!!B C
Value!!C H
)!!H I
;!!I J
}"" 
else"" 
{"" 
products## 
=## 
_service## #
.### $
GetAllProducts##$ 2
(##2 3
)##3 4
;##4 5
}$$ 
return&& 
Ok&& 
(&& 
_mapper&& 
.&& 
Map&& !
<&&! "
IEnumerable&&" -
<&&- .
ProductModel&&. :
>&&: ;
>&&; <
(&&< =
products&&= E
)&&E F
)&&F G
;&&G H
}'' 	
[** 	
HttpGet**	 
(** 
$str** 
)** 
]** 
public++ 
ActionResult++ 
<++ 
ProductModel++ (
>++( )
GetProductById++* 8
(++8 9
int++9 <
prodId++= C
)++C D
{,, 	
Product-- 
foundProduct--  
;--  !
try.. 
{.. 
foundProduct// 
=// 
_service// '
.//' (
GetProductById//( 6
(//6 7
prodId//7 =
)//= >
;//> ?
}00 
catch00 
(00 
RequestException00 %
)00% &
{00' (
return11 
NotFound11 
(11  
new11  #
{11$ %
message11% ,
=11- .
$str11/ E
}11E F
)11F G
;11G H
}22 
return44 
Ok44 
(44 
_mapper44 
.44 
Map44 !
<44! "
ProductModel44" .
>44. /
(44/ 0
foundProduct440 <
)44< =
)44= >
;44> ?
}55 	
}66 
}77 —
Ω/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Controllers/Products/ProductsOfRestaurantController.cs
	namespace

 	
glovo_webapi


 
.

 
Controllers

 "
.

" #
Products

# +
{ 
[ 
ApiController 
] 
[ 
Route 

(
 
$str 
) 
] 
public 

class *
ProductsOfRestaurantController /
:0 1
ControllerBase2 @
{ 
private 
readonly 
IProductsService )
_service* 2
;2 3
private 
readonly 
IMapper  
_mapper! (
;( )
public *
ProductsOfRestaurantController -
(- .
IProductsService. >
service? F
,F G
IMapperH O
mapperP V
)V W
{ 	
_service 
= 
service 
; 
_mapper 
= 
mapper 
; 
} 	
[ 	
HttpGet	 
( 
$str $
)$ %
]% &
public 
ActionResult 
< 
ProductModel (
>( )&
GetAllProductsOfRestaurant* D
(D E
intE H
idRestI O
,O P
[Q R
	FromQueryR [
][ \
ProductCategory\ k
?k l
categorym u
)u v
{ 	
IEnumerable 
< 
Product 
>  
products! )
;) *
try 
{ 
if 
( 
category 
. 
HasValue %
)% &
products 
= 
_service '
.' (0
$GetAllProductsOfRestaurantByCategory( L
(L M
idRestM S
,S T
categoryU ]
.] ^
Value^ c
)c d
;d e
else   
products!! 
=!! 
_service!! '
.!!' (&
GetAllProductsOfRestaurant!!( B
(!!B C
idRest!!C I
)!!I J
;!!J K
}"" 
catch"" 
("" 
RequestException"" %
)""% &
{""' (
return## 
NotFound## 
(##  
new##  #
{##$ %
message##% ,
=##- .
$str##/ H
}##H I
)##I J
;##J K
}$$ 
return&& 
Ok&& 
(&& 
_mapper&& 
.&& 
Map&& !
<&&! "
IEnumerable&&" -
<&&- .
ProductModel&&. :
>&&: ;
>&&; <
(&&< =
products&&= E
)&&E F
)&&F G
;&&G H
}'' 	
}(( 
})) è-
∑/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Controllers/Restaurants/RestaurantsController.cs
	namespace 	
glovo_webapi
 
. 
Controllers "
." #
Restaurants# .
{ 
[ 
ApiController 
] 
[ 
Route 

(
 
$str 
) 
] 
public 

class !
RestaurantsController &
:' (
ControllerBase) 7
{ 
private 
readonly 
IRestaurantsService ,
_restaurantsService- @
;@ A
private 
readonly 
IMapper  
_mapper! (
;( )
public !
RestaurantsController $
($ %
IRestaurantsService% 8
restaurantsService9 K
,K L
IMapperM T
mapperU [
)[ \
{ 	
_restaurantsService 
=  !
restaurantsService" 4
;4 5
_mapper 
= 
mapper 
; 
} 	
[ 	
HttpGet	 
] 
public 
ActionResult 
< 
IEnumerable '
<' (#
LocationRestaurantModel( ?
>? @
>@ A
GetAllRestaurantsB S
(S T
)T U
{ 	
IEnumerable 
< 

Restaurant "
>" #
restaurants$ /
=0 1
_restaurantsService2 E
.E F
GetAllRestaurantsF W
(W X
)X Y
;Y Z
return   
Ok   
(   
_mapper   
.   
Map   !
<  ! "
IEnumerable  " -
<  - .#
LocationRestaurantModel  . E
>  E F
>  F G
(  G H
restaurants  H S
)  S T
)  T U
;  U V
}!! 	
[$$ 	
HttpGet$$	 
($$ 
$str$$ 
)$$ 
]$$ 
public%% 
ActionResult%% 
<%% #
LocationRestaurantModel%% 3
>%%3 4
GetRestaurantById%%5 F
(%%F G
int%%G J
restId%%K Q
)%%Q R
{&& 	

Restaurant'' 
foundRestaurant'' &
;''& '
try(( 
{(( 
foundRestaurant)) 
=))  !
_restaurantsService))" 5
.))5 6
GetRestaurantById))6 G
())G H
restId))H N
)))N O
;))O P
}** 
catch** 
(** 
RequestException** %
)**% &
{**' (
return++ 
NotFound++ 
(++  
new++  #
{++$ %
message++% ,
=++- .
$str++/ H
}++H I
)++I J
;++J K
},, 
return.. 
Ok.. 
(.. 
_mapper.. 
... 
Map.. !
<..! "#
LocationRestaurantModel.." 9
>..9 :
(..: ;
foundRestaurant..; J
)..J K
)..K L
;..L M
}// 	
[22 	
HttpGet22	 
(22 
$str22 
)22 
]22 
public33 
ActionResult33 
<33 #
DistanceRestaurantModel33 3
>333 4!
GetClosestRestaurants335 J
(33J K
[33K L
	FromQuery33L U
]33U V
LocationModel33V c
userLocation33d p
)33p q
{44 	
IEnumerable55 
<55 

Restaurant55 "
>55" #
restaurants55$ /
=550 1
_restaurantsService552 E
.55E F
GetAllRestaurants55F W
(55W X
)55X Y
;55Y Z
IEnumerable66 
<66 #
DistanceRestaurantModel66 /
>66/ 0 
viewRestaurantModels661 E
=66F G
_mapper77 
.77 
Map77 
<77 
IEnumerable77 '
<77' (#
DistanceRestaurantModel77( ?
>77? @
>77@ A
(77A B
restaurants88 
,88  
opts99 
=>99 
{:: 
opts;; 
.;; 
Items;; "
[;;" #
$str;;# 1
];;1 2
=;;3 4
_mapper;;5 <
.;;< =
Map;;= @
<;;@ A
Location;;A I
>;;I J
(;;J K
userLocation;;K W
);;W X
;;;X Y
opts<< 
.<< 
Items<< "
[<<" #
$str<<# :
]<<: ;
=<<< =
new<<> A
Func<<B F
<<<F G
double<<G M
,<<M N
double<<O U
><<U V
(<<V W
d<<W X
=><<Y [
{<<\ ]
return<<^ d
$num<<e h
+<<i j
$num<<k n
*<<o p
d<<q r
;<<r s
}<<s t
)<<t u
;<<u v
}== 
)== 
;==  
viewRestaurantModels??  
=??! "
(@@ 
(@@ 
List@@ 
<@@ #
DistanceRestaurantModel@@ .
>@@. /
)@@/ 0 
viewRestaurantModels@@1 E
)@@E F
.@@F G
OrderBy@@G N
(@@N O
vrm@@O R
=>@@S U
vrm@@V Y
.@@Y Z
Distance@@Z b
)@@b c
.@@c d
ToList@@d j
(@@j k
)@@k l
;@@l m
returnBB 
OkBB 
(BB  
viewRestaurantModelsBB *
)BB* +
;BB+ ,
}CC 	
}DD 
}EE ø7
±/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Controllers/Users/UserAccountController.cs
	namespace 	
glovo_webapi
 
. 
Controllers "
." #
Users# (
{ 
[ 
ApiController 
] 
[ 
Route 

(
 
$str 
) 
] 
public 

class !
UserAccountController &
:' (
ControllerBase) 7
{ 
private 
readonly 
IUsersService &
_userService' 3
;3 4
private 
readonly 
IMapper  
_mapper! (
;( )
private 
readonly !
TokenCreatorValidator ."
_tokenCreatorValidator/ E
;E F
public !
UserAccountController $
($ %
IUsersService 
userService %
,% &
IMapper 
mapper 
, 
IOptions 
< 
AppConfiguration %
>% &
configuration' 4
)4 5
{ 	
_userService 
= 
userService &
;& '
_mapper 
= 
mapper 
; "
_tokenCreatorValidator   "
=  # $
new  % (!
TokenCreatorValidator  ) >
(  > ?
configuration  ? L
.  L M
Value  M R
.  R S
Secret  S Y
)  Y Z
;  Z [
}!! 	
[$$ 	
HttpPost$$	 
($$ 
$str$$ 
)$$ 
]$$ 
public%% 
ActionResult%% 
<%% 
SendLoginUserModel%% .
>%%. /
Authenticate%%0 <
(%%< =
[%%= >
FromBody%%> F
]%%F G!
ReceiveLoginUserModel%%G \
	userModel%%] f
)%%f g
{&& 	
User'' 
user'' 
;'' 
try(( 
{(( 
user)) 
=)) 
_userService)) #
.))# $
Authenticate))$ 0
())0 1
	userModel))1 :
.)): ;
Email)); @
,))@ A
	userModel))B K
.))K L
Password))L T
)))T U
;))U V
}** 
catch** 
(** 
RequestException** %
)**% &
{**' (
return++ 

BadRequest++ !
(++! "
new++" %
{++& '
message++' .
=++/ 0
$str++1 Q
}++R S
)++S T
;++T U
},, 
TokenCreationParams.. 
tokenCreationParams..  3
=..4 5"
_tokenCreatorValidator..6 L
...L M
CreateToken..M X
(..X Y
user..Y ]
...] ^
Id..^ `
,..` a
$num..b d
*..e f
$num..g i
*..j k
$num..l m
)..m n
;..n o
user// 
.// 
AuthSalt// 
=// 
tokenCreationParams// /
./// 0
	SaltBytes//0 9
;//9 :
_userService11 
.11 
Update11 
(11  
user11  $
)11$ %
;11% &
SendLoginUserModel33 
sendLoginUserModel33 1
=332 3
_mapper334 ;
.33; <
Map33< ?
<33? @
SendLoginUserModel33@ R
>33R S
(33S T
user33T X
)33X Y
;33Y Z
sendLoginUserModel44 
.44 
Token44 $
=44% &
tokenCreationParams44' :
.44: ;
TokenStr44; C
;44C D
return55 
Ok55 
(55 
sendLoginUserModel55 (
)55( )
;55) *
}66 	
[99 	
HttpPost99	 
(99 
$str99 
)99 
]99 
public:: 
ActionResult:: 
Register:: $
(::$ %
[::% &
FromBody::& .
]::. /
RegisterUserModel::/ @
	userModel::A J
)::J K
{;; 	
var== 
user== 
=== 
_mapper== 
.== 
Map== "
<==" #
User==# '
>==' (
(==( )
	userModel==) 2
)==2 3
;==3 4
try?? 
{?? 
_userService@@ 
.@@ 
Create@@ #
(@@# $
user@@$ (
,@@( )
	userModel@@* 3
.@@3 4
Password@@4 <
)@@< =
;@@= >
}AA 
catchAA 
(AA 
RequestExceptionAA %
exAA& (
)AA( )
{AA* +
ifBB 
(BB 
exBB 
.BB 
CodeBB 
==BB 
UserExceptionCodesBB 1
.BB1 2
BadPasswordBB2 =
)BB= >
returnCC 

BadRequestCC %
(CC% &
newCC& )
{CC* +
messageCC+ 2
=CC3 4
$strCC5 Y
}CCZ [
)CC[ \
;CC\ ]
ifDD 
(DD 
exDD 
.DD 
CodeDD 
==DD 
UserExceptionCodesDD 1
.DD1 2
EmailAlreadyExistsDD2 D
)DDD E
returnEE 

BadRequestEE %
(EE% &
newEE& )
{EE* +
messageEE+ 2
=EE3 4
$strEE5 K
}EEL M
)EEM N
;EEN O
returnFF 

BadRequestFF !
(FF! "
newFF" %
{FF& '
messageFF' .
=FF/ 0
$strFF1 @
}FF@ A
)FFA B
;FFB C
}GG 
returnII 
OkII 
(II 
)II 
;II 
}JJ 	
[LL 	
	AuthorizeLL	 
(LL 
RolesLL 
=LL 
$strLL 1
)LL1 2
]LL2 3
[MM 	
HttpPostMM	 
(MM 
$strMM 
)MM 
]MM 
publicNN 
ActionResultNN 
LogoutNN "
(NN" #
)NN# $
{OO 	
UserPP 

loggedUserPP 
=PP 
(PP 
UserPP #
)PP# $
HttpContextPP$ /
.PP/ 0
ItemsPP0 5
[PP5 6
$strPP6 <
]PP< =
;PP= >
ifQQ 
(QQ 

loggedUserQQ 
==QQ 
nullQQ !
)QQ! "
returnRR 
NotFoundRR 
(RR  
newRR  #
{RR$ %
messageRR% ,
=RR- .
$strRR/ B
}RRB C
)RRC D
;RRD E

loggedUserTT 
.TT 
AuthSaltTT 
=TT  !
nullTT" &
;TT& '
_userServiceUU 
.UU 
UpdateUU 
(UU  

loggedUserUU  *
)UU* +
;UU+ ,
returnVV 
OkVV 
(VV 
)VV 
;VV 
}WW 	
}XX 
}YY ∂=
π/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Controllers/Users/UserAccountRecoveryController.cs
	namespace 	
glovo_webapi
 
. 
Controllers "
." #
Users# (
{ 
[ 
ApiController 
] 
[ 
Route 

(
 
$str 
) 
] 
public 

class )
UserAccountRecoveryController .
:/ 0
ControllerBase1 ?
{ 
private 
readonly 
IUsersService &
_userService' 3
;3 4
private 
readonly 
IMapper  
_mapper! (
;( )
private 
readonly !
TokenCreatorValidator ."
_tokenCreatorValidator/ E
;E F
public )
UserAccountRecoveryController ,
(, -
IUsersService 
userService %
,% &
IMapper 
mapper 
, 
IOptions 
< 
AppConfiguration %
>% &
configuration' 4
)4 5
{ 	
_userService 
= 
userService &
;& '
_mapper 
= 
mapper 
; "
_tokenCreatorValidator   "
=  # $
new  % (!
TokenCreatorValidator  ) >
(  > ?
configuration  ? L
.  L M
Value  M R
.  R S
Secret  S Y
)  Y Z
;  Z [
}!! 	
[$$ 	
HttpPost$$	 
($$ 
$str$$ "
)$$" #
]$$# $
public%% 
ActionResult%% 
<%% 
PasswordEmailModel%% .
>%%. /
SendPasswordEmail%%0 A
(%%A B
[%%B C
FromBody%%C K
]%%K L
PasswordEmailModel%%M _
passwordEmailModel%%` r
)%%r s
{&& 	
User'' 
user'' 
;'' 
try(( 
{(( 
user)) 
=)) 
_userService)) #
.))# $

GetByEmail))$ .
()). /
passwordEmailModel))/ A
.))A B
Email))B G
)))G H
;))H I
}** 
catch** 
(** 
RequestException** %
)**% &
{**' (
return++ 

BadRequest++ !
(++! "
new++" %
{++& '
message++' .
=++/ 0
$str++1 E
}++F G
)++G H
;++H I
},, 
TokenCreationParams.. 
tokenCreationParams..  3
=..4 5"
_tokenCreatorValidator..6 L
...L M
CreateToken..M X
(..X Y
user..Y ]
...] ^
Id..^ `
,..` a
$num..b d
)..d e
;..e f
user00 
.00 
RecoverySalt00 
=00 
tokenCreationParams00  3
.003 4
	SaltBytes004 =
;00= >
_userService11 
.11 
Update11 
(11  
user11  $
)11$ %
;11% &

MailSender33 
.33 
SendRecoveryMail33 '
(33' (
user33( ,
,33, -
tokenCreationParams33. A
.33A B
TokenStr33B J
)33J K
;33K L
return55 
Ok55 
(55 
new55 
PasswordEmailModel55 ,
{66 
Email77 
=77 
user77 
.77 
Email77 "
,77" #
}88 
)88 
;88 
}99 	
[<< 	
HttpPost<<	 
(<< 
$str<< "
)<<" #
]<<# $
public== 
ActionResult== 
ResetPassword== )
(==) *
[==* +
FromBody==+ 3
]==3 4
PasswordResetModel==4 F
passwordResetModel==G Y
)==Y Z
{>> 	
User?? 
user?? 
;?? 
try@@ 
{@@ 
userAA 
=AA 
_userServiceAA #
.AA# $

GetByEmailAA$ .
(AA. /
passwordResetModelAA/ A
.AAA B
EmailAAB G
)AAG H
;AAH I
}BB 
catchBB 
(BB 
RequestExceptionBB %
)BB% &
{BB' (
returnCC 

BadRequestCC !
(CC! "
newCC" %
{CC& '
messageCC' .
=CC/ 0
$strCC1 G
}CCH I
)CCI J
;CCJ K
}DD !
TokenValidationParamsFF !!
tokenValidationParamsFF" 7
;FF7 8
UserGG 
	tokenUserGG 
;GG 
tryHH 
{HH !
tokenValidationParamsII %
=II& '"
_tokenCreatorValidatorII( >
.II> ?
ValidateTokenII? L
(IIL M
passwordResetModelIIM _
.II_ `
RecoveryTokenII` m
)IIm n
;IIn o
	tokenUserJJ 
=JJ 
_userServiceJJ (
.JJ( )
GetByIdJJ) 0
(JJ0 1!
tokenValidationParamsJJ1 F
.JJF G
UserIdJJG M
)JJM N
;JJN O
}KK 
catchKK 
(KK 
	ExceptionKK 
)KK 
{KK  !
returnLL 

BadRequestLL !
(LL! "
newLL" %
{LL& '
messageLL' .
=LL/ 0
$strLL1 F
}LLG H
)LLH I
;LLI J
}MM 
ifOO 
(OO 
EncodingOO 
.OO 
DefaultOO  
.OO  !
	GetStringOO! *
(OO* +
	tokenUserOO+ 4
.OO4 5
RecoverySaltOO5 A
)OOA B
!=OOC E
EncodingPP 
.PP 
DefaultPP  
.PP  !
	GetStringPP! *
(PP* +!
tokenValidationParamsPP+ @
.PP@ A
	SaltBytesPPA J
)PPJ K
)PPK L
returnQQ 

BadRequestQQ !
(QQ! "
newQQ" %
{QQ& '
messageQQ' .
=QQ/ 0
$strQQ1 S
}QQT U
)QQU V
;QQV W
userSS 
.SS 
RecoverySaltSS 
=SS 
nullSS  $
;SS$ %
tryUU 
{UU 
_userServiceVV 
.VV 
SetNewPasswordVV +
(VV+ ,
userVV, 0
,VV0 1
passwordResetModelVV2 D
.VVD E
NewPasswordVVE P
)VVP Q
;VVQ R
}WW 
catchXX 
(XX 
RequestExceptionXX "
exXX# %
)XX% &
{XX' (
ifYY 
(YY 
exYY 
.YY 
CodeYY 
==YY 
UserExceptionCodesYY 0
.YY0 1
InvalidCredentialsYY1 C
)YYC D
returnZZ 

BadRequestZZ %
(ZZ% &
newZZ& )
{ZZ* +
messageZZ+ 2
=ZZ3 4
$strZZ5 K
}ZZK L
)ZZL M
;ZZM N
if[[ 
([[ 
ex[[ 
.[[ 
Code[[ 
==[[ 
UserExceptionCodes[[ 0
.[[0 1
BadPassword[[1 <
)[[< =
return\\ 

BadRequest\\ %
(\\% &
new\\& )
{\\* +
message\\+ 2
=\\3 4
$str\\5 K
}\\K L
)\\L M
;\\M N
return]] 

BadRequest]] !
(]]! "
new]]" %
{]]& '
message]]' .
=]]/ 0
$str]]1 @
}]]@ A
)]]A B
;]]B C
}^^ 
return`` 
Ok`` 
(`` 
)`` 
;`` 
}aa 	
}bb 
}cc ö
≤/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Controllers/Users/UserLocationController.cs
	namespace		 	
glovo_webapi		
 
.		 
Controllers		 "
.		" #
Users		# (
{

 
[ 
ApiController 
] 
[ 
Route 

(
 
$str 
) 
] 
public 

class "
UserLocationController '
:( )
ControllerBase* 8
{ 
private 
readonly 
IUsersService &
_userService' 3
;3 4
private 
readonly 
IMapper  
_mapper! (
;( )
public "
UserLocationController %
(% &
IUsersService 
userService %
,% &
IMapper 
mapper 
) 
{ 	
_userService 
= 
userService &
;& '
_mapper 
= 
mapper 
; 
} 	
[ 	
	Authorize	 
] 
[ 	
HttpGet	 
( 
$str "
)" #
]# $
public 
ActionResult 
< 
LocationModel )
>) *
GetUserLocation+ :
(: ;
); <
{   	
User!! 

loggedUser!! 
=!! 
(!! 
User!! #
)!!# $
HttpContext!!$ /
.!!/ 0
Items!!0 5
[!!5 6
$str!!6 <
]!!< =
;!!= >
if"" 
("" 

loggedUser"" 
=="" 
null"" !
)""! "
return## 
NotFound## 
(##  
new##  #
{##$ %
message##% ,
=##- .
$str##/ B
}##B C
)##C D
;##D E
return%% 
Ok%% 
(%% 
_mapper%% 
.%% 
Map%% !
<%%! "
LocationModel%%" /
>%%/ 0
(%%0 1

loggedUser%%1 ;
.%%; <
Location%%< D
)%%D E
)%%E F
;%%F G
}&& 	
[)) 	
	Authorize))	 
])) 
[** 	
HttpPost**	 
(** 
$str** #
)**# $
]**$ %
public++ 
ActionResult++ 
<++ 
LocationModel++ )
>++) *
PostUserLocation+++ ;
(++; <
[++< =
FromBody++= E
]++E F
LocationModel++F S
newLocation++T _
)++_ `
{,, 	
User-- 

loggedUser-- 
=-- 
(-- 
User-- #
)--# $
HttpContext--$ /
.--/ 0
Items--0 5
[--5 6
$str--6 <
]--< =
;--= >
if.. 
(.. 

loggedUser.. 
==.. 
null.. !
)..! "
return// 
NotFound// 
(//  
new//  #
{//$ %
message//% ,
=//- .
$str/// B
}//B C
)//C D
;//D E

loggedUser11 
.11 
Location11 
=11  !
_mapper11" )
.11) *
Map11* -
<11- .
Location11. 6
>116 7
(117 8
newLocation118 C
)11C D
;11D E
_userService33 
.33 
Update33 
(33  

loggedUser33  *
)33* +
;33+ ,
return55 
Ok55 
(55 
_mapper55 
.55 
Map55 !
<55! "
LocationModel55" /
>55/ 0
(550 1

loggedUser551 ;
.55; <
Location55< D
)55D E
)55E F
;55F G
}66 	
}77 
}88 ∫X
´/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Controllers/Users/UsersController.cs
	namespace 	
glovo_webapi
 
. 
Controllers "
." #
Users# (
{ 
[ 
ApiController 
] 
[ 
Route 

(
 
$str 
) 
] 
public 

class 
UsersController  
:! "
ControllerBase# 1
{ 
private 
readonly 
IUsersService &
_userService' 3
;3 4
private 
readonly 
IMapper  
_mapper! (
;( )
public 
UsersController 
( 
IUsersService 
userService %
,% &
IMapper 
mapper 
) 
{ 	
_userService 
= 
userService &
;& '
_mapper 
= 
mapper 
; 
} 	
[ 	
	Authorize	 
( 
Roles 
= 
$str (
)( )
]) *
[ 	
HttpGet	 
] 
public   
ActionResult   
<   
IEnumerable   '
<  ' (
	UserModel  ( 1
>  1 2
>  2 3
GetAll  4 :
(  : ;
)  ; <
{!! 	
IEnumerable"" 
<"" 
User"" 
>"" 
users"" #
=""$ %
_userService""& 2
.""2 3
GetAll""3 9
(""9 :
)"": ;
;""; <
return## 
Ok## 
(## 
_mapper## 
.## 
Map## !
<##! "
IEnumerable##" -
<##- .
	UserModel##. 7
>##7 8
>##8 9
(##9 :
users##: ?
)##? @
)##@ A
;##A B
}$$ 	
['' 	
	Authorize''	 
('' 
Roles'' 
='' 
$str'' 1
)''1 2
]''2 3
[(( 	
HttpGet((	 
((( 
$str(( 
)(( 
](( 
public)) 
ActionResult)) 
<)) 
	UserModel)) %
>))% &
GetById))' .
()). /
int))/ 2
userId))3 9
)))9 :
{** 	
User++ 
user++ 
;++ 
try,, 
{,, 
user-- 
=-- 
_userService-- #
.--# $
GetById--$ +
(--+ ,
userId--, 2
)--2 3
;--3 4
}.. 
catch.. 
(.. 
RequestException.. $
)..$ %
{..& '
return// 
NotFound// 
(//  
new//  #
{//$ %
message//% ,
=//- .
$str/// B
}//B C
)//C D
;//D E
}00 
User22 

loggedUser22 
=22 
(22 
User22 #
)22# $
HttpContext22$ /
.22/ 0
Items220 5
[225 6
$str226 <
]22< =
;22= >
if33 
(33 

loggedUser33 
==33 
null33 !
)33! "
return44 
NotFound44 
(44  
new44  #
{44$ %
message44% ,
=44- .
$str44/ B
}44B C
)44C D
;44D E
if55 
(55 

loggedUser55 
.55 
Role55 
==55  "
UserRole55# +
.55+ ,
Regular55, 3
&&554 6
user557 ;
.55; <
Id55< >
!=55? A

loggedUser55B L
.55L M
Id55M O
)55O P
return66 
Unauthorized66 #
(66# $
new66$ '
{66( )
message66) 0
=661 2
$str663 A
}66A B
)66B C
;66C D
var88 
model88 
=88 
_mapper88 
.88  
Map88  #
<88# $
	UserModel88$ -
>88- .
(88. /
user88/ 3
)883 4
;884 5
return99 
Ok99 
(99 
model99 
)99 
;99 
}:: 	
[== 	
	Authorize==	 
(== 
Roles== 
=== 
$str== 1
)==1 2
]==2 3
[>> 	
HttpPut>>	 
(>> 
$str>> 
)>> 
]>> 
public?? 
ActionResult?? 
<?? 
UpdateUserModel?? +
>??+ ,
Update??- 3
(??3 4
[??4 5
FromBody??5 =
]??= >
UpdateUserModel??> M
model??N S
)??S T
{@@ 	
UserAA 

loggedUserAA 
=AA 
(AA 
UserAA #
)AA# $
HttpContextAA$ /
.AA/ 0
ItemsAA0 5
[AA5 6
$strAA6 <
]AA< =
;AA= >
ifBB 
(BB 

loggedUserBB 
==BB 
nullBB !
)BB! "
returnCC 
NotFoundCC 
(CC  
newCC  #
{CC$ %
messageCC% ,
=CC- .
$strCC/ B
}CCB C
)CCC D
;CCD E
tryEE 
{EE 
_userServiceFF 
.FF 

SetProfileFF '
(FF' (

loggedUserFF( 2
,FF2 3
modelFF4 9
.FF9 :
NameFF: >
,FF> ?
modelFF@ E
.FFE F
EmailFFF K
)FFK L
;FFL M
}GG 
catchGG 
(GG 
RequestExceptionGG %
exGG& (
)GG( )
{GG* +
ifHH 
(HH 
exHH 
.HH 
CodeHH 
==HH 
UserExceptionCodesHH 1
.HH1 2
EmailAlreadyExistsHH2 D
)HHD E
returnII 

BadRequestII %
(II% &
newII& )
{II* +
messageII+ 2
=II3 4
$strII5 K
}IIK L
)IIL M
;IIM N
returnJJ 

BadRequestJJ !
(JJ! "
newJJ" %
{JJ& '
messageJJ' .
=JJ/ 0
$strJJ1 @
}JJ@ A
)JJA B
;JJB C
}KK 
returnMM 
OkMM 
(MM 
newMM 
UpdateUserModelMM )
(MM) *
)MM* +
{NN 
EmailOO 
=OO 

loggedUserOO "
.OO" #
EmailOO# (
,OO( )
NamePP 
=PP 

loggedUserPP !
.PP! "
NamePP" &
}QQ 
)QQ 
;QQ 
}RR 	
[UU 	
	AuthorizeUU	 
(UU 
RolesUU 
=UU 
$strUU 1
)UU1 2
]UU2 3
[VV 	
HttpPutVV	 
(VV 
$strVV "
)VV" #
]VV# $
publicWW 
ActionResultWW 
UpdatePasswordWW *
(WW* +
[WW+ ,
FromBodyWW, 4
]WW4 5
PasswordUpdateModelWW5 H
modelWWI N
)WWN O
{XX 	
UserZZ 

loggedUserZZ 
=ZZ 
(ZZ 
UserZZ #
)ZZ# $
HttpContextZZ$ /
.ZZ/ 0
ItemsZZ0 5
[ZZ5 6
$strZZ6 <
]ZZ< =
;ZZ= >
if[[ 
([[ 

loggedUser[[ 
==[[ 
null[[ !
)[[! "
return\\ 
NotFound\\ 
(\\  
new\\  #
{\\$ %
message\\% ,
=\\- .
$str\\/ B
}\\B C
)\\C D
;\\D E
try^^ 
{^^ 
_userService__ 
.__ 
SetNewPassword__ +
(__+ ,

loggedUser__, 6
,__6 7
model__8 =
.__= >
NewPassword__> I
,__I J
model__K P
.__P Q
OldPassword__Q \
)__\ ]
;__] ^
}`` 
catch`` 
(`` 
RequestException`` %
ex``& (
)``( )
{``* +
ifaa 
(aa 
exaa 
.aa 
Codeaa 
==aa 
UserExceptionCodesaa 1
.aa1 2
BadPasswordaa2 =
)aa= >
returnbb 

BadRequestbb %
(bb% &
newbb& )
{bb* +
messagebb+ 2
=bb3 4
$strbb5 Y
}bbY Z
)bbZ [
;bb[ \
ifcc 
(cc 
excc 
.cc 
Codecc 
==cc 
UserExceptionCodescc 1
.cc1 2
InvalidCredentialscc2 D
)ccD E
returndd 

BadRequestdd %
(dd% &
newdd& )
{dd* +
messagedd+ 2
=dd3 4
$strdd5 Q
}ddQ R
)ddR S
;ddS T
returnee 

BadRequestee !
(ee! "
newee" %
{ee& '
messageee' .
=ee/ 0
$stree1 @
}ee@ A
)eeA B
;eeB C
}ff 
returnhh 
Okhh 
(hh 
)hh 
;hh 
}ii 	
[ll 	
	Authorizell	 
(ll 
Rolesll 
=ll 
$strll 1
)ll1 2
]ll2 3
[mm 	

HttpDeletemm	 
(mm 
$strmm 
)mm 
]mm  
publicnn 
ActionResultnn 
Deletenn "
(nn" #
intnn# &
userIdnn' -
)nn- .
{oo 	
Userpp 

loggedUserpp 
=pp 
(pp 
Userpp #
)pp# $
HttpContextpp$ /
.pp/ 0
Itemspp0 5
[pp5 6
$strpp6 <
]pp< =
;pp= >
ifqq 
(qq 

loggedUserqq 
==qq 
nullqq !
)qq! "
returnrr 
NotFoundrr 
(rr  
newrr  #
{rr$ %
messagerr% ,
=rr- .
$strrr/ B
}rrB C
)rrC D
;rrD E
ifss 
(ss 

loggedUserss 
.ss 
Roless 
==ss  "
UserRoless# +
.ss+ ,
Regularss, 3
&&ss4 6
userIdss7 =
!=ss> @

loggedUserssA K
.ssK L
IdssL N
)ssN O
returntt 
Unauthorizedtt #
(tt# $
newtt$ '
{tt( )
messagett) 0
=tt1 2
$strtt3 A
}ttA B
)ttB C
;ttC D
tryvv 
{vv 
_userServiceww 
.ww 
Deleteww #
(ww# $
userIdww$ *
)ww* +
;ww+ ,
}xx 
catchxx 
(xx 
RequestExceptionxx %
)xx% &
{xx' (
returnyy 
NotFoundyy 
(yy  
newyy  #
{yy$ %
messageyy% ,
=yy- .
$stryy/ B
}yyB C
)yyC D
;yyD E
}zz 
return|| 
Ok|| 
(|| 
)|| 
;|| 
}}} 	
}~~ 
} ∑
ù/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Data/GlovoDBContext.cs
	namespace 	
glovo_webapi
 
. 
Data 
{ 
public 

class 
GlovoDbContext 
:  !
	DbContext" +
{ 
	protected 
override 
void 
OnModelCreating  /
(/ 0
ModelBuilder0 <
modelBuilder= I
)I J
{		 	
modelBuilder

 
.

 
Entity

 
<

  
OrderProduct

  ,
>

, -
(

- .
)

. /
. 
HasKey 
( 
o 
=> 
new  
{! "
o" #
.# $
OrderId$ +
,+ ,
o- .
.. /
	ProductId/ 8
}8 9
)9 :
;: ;
} 	
public 
GlovoDbContext 
( 
DbContextOptions .
<. /
GlovoDbContext/ =
>= >
opt? B
)B C
:D E
baseF J
(J K
optK N
)N O
{P Q
}R S
public 
DbSet 
< 

Restaurant 
>  
Restaurants! ,
{- .
get/ 2
;2 3
set4 7
;7 8
}9 :
public 
DbSet 
< 
User 
> 
Users  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 
DbSet 
< 
Product 
> 
Products &
{' (
get) ,
;, -
set. 1
;1 2
}3 4
public 
DbSet 
< 
Order 
> 
Orders "
{# $
get% (
;( )
set* -
;- .
}/ 0
public 
DbSet 
< 
OrderProduct !
>! "
OrdersProducts# 1
{2 3
get4 7
;7 8
set9 <
;< =
}> ?
} 
} Ò 
õ/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Entities/Location.cs
	namespace 	
glovo_webapi
 
. 
Entities 
{ 
[ 
Owned 

]
 
public 

class 
Location 
{		 
[

 	
Required

	 
,

 
Range

 
(

 
-

 
$num

 
,

 
$num

  
)

  !
]

! "
public 
double 
Latitude 
{  
get! $
;$ %
set& )
;) *
}+ ,
[ 	
Required	 
, 
Range 
( 
- 
$num 
, 
$num "
)" #
]# $
public 
double 
	Longitude 
{  !
get" %
;% &
set' *
;* +
}, -
public 
Location 
( 
) 
{ 
} 
public 
Location 
( 
double 
latitude '
,' (
double) /
	longitude0 9
)9 :
{ 	
Latitude 
= 
latitude 
;  
	Longitude 
= 
	longitude !
;! "
} 	
private 
const 
double 
R 
=  
$num! %
;% &
public 
double 

DistanceTo  
(  !
Location! )
location* 2
)2 3
{ 	
double 
latRad1 
= 
Latitude %
*& '
Math( ,
., -
PI- /
/0 1
$num2 7
;7 8
double 
latRad2 
= 
location %
.% &
Latitude& .
*/ 0
Math1 5
.5 6
PI6 8
/9 :
$num; @
;@ A
double 
difLat 
= 
( 
Latitude %
-& '
location( 0
.0 1
Latitude1 9
)9 :
*; <
Math= A
.A B
PIB D
/E F
$numG L
;L M
double 
difLon 
= 
( 
	Longitude &
-' (
location) 1
.1 2
	Longitude2 ;
); <
*= >
Math? C
.C D
PID F
/G H
$numI N
;N O
double 
a 
= 
Math 
. 
Sin 
(  
difLat  &
/' (
$num) *
)* +
*, -
Math. 2
.2 3
Sin3 6
(6 7
difLat7 =
/> ?
$num@ A
)A B
+C D
Math   
.   
Cos   
(    
latRad1    '
)  ' (
*  ) *
Math  + /
.  / 0
Cos  0 3
(  3 4
latRad2  4 ;
)  ; <
*  = >
Math  ? C
.  C D
Sin  D G
(  G H
difLon  H N
/  O P
$num  Q R
)  R S
*  T U
Math  V Z
.  Z [
Sin  [ ^
(  ^ _
difLon  _ e
/  f g
$num  h i
)  i j
;  j k
double!! 
c!! 
=!! 
$num!! 
*!! 
Math!! 
.!!  
Atan2!!  %
(!!% &
Math!!& *
.!!* +
Sqrt!!+ /
(!!/ 0
a!!0 1
)!!1 2
,!!2 3
Math!!4 8
.!!8 9
Sqrt!!9 =
(!!= >
$num!!> ?
-!!@ A
a!!B C
)!!C D
)!!D E
;!!E F
return## 
R## 
*## 
c## 
;## 
}$$ 	
}%% 
}&& §
ò/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Entities/Order.cs
	namespace 	
glovo_webapi
 
. 
Entities 
{ 
public 

class 
Order 
{		 
[

 	
Key

	 
]

 
public 
int 
Id 
{ 
get 
; 
set  
;  !
}" #
[ 	
Required	 
] 
public 
DateTime 
BuyDateTime #
{$ %
get& )
;) *
set+ .
;. /
}0 1
[ 	
Required	 
, 

ForeignKey 
( 
$str $
)$ %
]% &
public 
int 
UserId 
{ 
get 
;  
set! $
;$ %
}& '
[ 	
Required	 
, 

ForeignKey 
( 
$str *
)* +
]+ ,
public 
int 
RestaurantId 
{  !
get" %
;% &
set' *
;* +
}, -
public 
User 
User 
{ 
get 
; 
set  #
;# $
}% &
public 

Restaurant 

Restaurant $
{% &
get' *
;* +
set, /
;/ 0
}1 2
public 
IEnumerable 
< 
OrderProduct '
>' (
OrdersProducts) 7
{8 9
get: =
;= >
set? B
;B C
}D E
public 
Order 
( 
) 
{ 
} 
public 
Order 
( 
DateTime 
buyDateTime )
,) *
int+ .
userId/ 5
,5 6
int7 :
restaurantId; G
)G H
{ 	
BuyDateTime 
= 
buyDateTime %
;% &
UserId 
= 
userId 
; 
RestaurantId   
=   
restaurantId   '
;  ' (
}!! 	
}"" 
}## Û
ü/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Entities/OrderProduct.cs
	namespace 	
glovo_webapi
 
. 
Entities 
{ 
public 

class 
OrderProduct 
{ 
[ 	
Key	 
, 

ForeignKey 
( 
$str  
)  !
]! "
public		 
int		 
OrderId		 
{		 
get		  
;		  !
set		" %
;		% &
}		' (
[ 	
Key	 
, 

ForeignKey 
( 
$str "
)" #
]# $
public 
int 
	ProductId 
{ 
get "
;" #
set$ '
;' (
}) *
[ 	
Required	 
] 
public 
int 
Quantity 
{ 
get !
;! "
set# &
;& '
}( )
public 
Order 
Order 
{ 
get  
;  !
set" %
;% &
}' (
public 
Product 
Product 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 
OrderProduct 
( 
) 
{ 
}  
public 
OrderProduct 
( 
int 
orderId  '
,' (
int) ,
	productId- 6
,6 7
int8 ;
quantity< D
)D E
{ 	
OrderId 
= 
orderId 
; 
	ProductId 
= 
	productId !
;! "
Quantity 
= 
quantity 
;  
} 	
} 
} ó
ö/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Entities/Product.cs
	namespace 	
glovo_webapi
 
. 
Entities 
{ 
public 

class 
Product 
{		 
[

 	
Key

	 
]

 
public 
int 
Id 
{ 
get 
; 
set  
;  !
}" #
[ 	
Required	 
] 
public 
string 
Name 
{ 
get  
;  !
set" %
;% &
}' (
public 
string 
ImgPath 
{ 
get  #
;# $
set% (
;( )
}* +
public 
string 
Description !
{" #
get$ '
;' (
set) ,
;, -
}. /
[ 	
Required	 
] 
public 
float 
Price 
{ 
get  
;  !
set" %
;% &
}' (
[ 	
Required	 
, 

ForeignKey 
( 
$str *
)* +
]+ ,
public 
int 
RestaurantId 
{  !
get" %
;% &
set' *
;* +
}, -
public 
ProductCategory 
Category '
{( )
get* -
;- .
set/ 2
;2 3
}4 5
public 

Restaurant 

Restaurant $
{% &
get' *
;* +
set, /
;/ 0
}1 2
public 
IEnumerable 
< 
OrderProduct '
>' (
OrdersProducts) 7
{8 9
get: =
;= >
set? B
;B C
}D E
public 
Product 
( 
) 
{ 
} 
public!! 
Product!! 
(!! 
string!! 
name!! "
,!!" #
string!!$ *
imgPath!!+ 2
,!!2 3
string!!4 :
description!!; F
,!!F G
float!!H M
price!!N S
,!!S T
int!!U X
restaurantId!!Y e
,!!e f
ProductCategory!!g v
category!!w 
)	!! Ä
{"" 	
Name## 
=## 
name## 
;## 
ImgPath$$ 
=$$ 
imgPath$$ 
;$$ 
Description%% 
=%% 
description%% %
;%%% &
Price&& 
=&& 
price&& 
;&& 
RestaurantId'' 
='' 
restaurantId'' '
;''' (
Category(( 
=(( 
category(( 
;((  
})) 	
}++ 
},, ´
¢/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Entities/ProductCategory.cs
	namespace 	
glovo_webapi
 
. 
Utils 
{ 
public 

enum 
ProductCategory 
{ 
Uncategorized 
, 
C1 

} 
} ˜
ù/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Entities/Restaurant.cs
	namespace 	
glovo_webapi
 
. 
Entities 
{ 
public 

class 

Restaurant 
{ 
[ 	
Key	 
] 
public		 
int		 
Id		 
{		 
get		 
;		 
set		  
;		  !
}		" #
[ 	
Required	 
] 
public 
string 
Name 
{ 
get  
;  !
set" %
;% &
}' (
public 
string 
ImgPath 
{ 
get  #
;# $
set% (
;( )
}* +
[ 	
Required	 
] 
public 
Location 
Location  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 
ICollection 
< 
Product "
>" #
Products$ ,
{- .
get/ 2
;2 3
set4 7
;7 8
}9 :
public 

Restaurant 
( 
) 
{ 
} 
public 

Restaurant 
( 
string  
name! %
,% &
string' -
imgPath. 5
,5 6
Location7 ?
location@ H
)H I
{ 	
Name 
= 
name 
; 
ImgPath 
= 
imgPath 
; 
Location 
= 
location 
;  
} 	
} 
} ˙ 
ó/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Entities/User.cs
	namespace 	
glovo_webapi
 
. 
Entities 
{ 
public 

class 
User 
{ 
[		 	
Key			 
]		 
public

 
int

 
Id

 
{

 
get

 
;

 
set

  
;

  !
}

" #
[ 	
Required	 
] 
public 
string 
Name 
{ 
get  
;  !
set" %
;% &
}' (
[ 	
Required	 
] 
public 
string 
Email 
{ 
get !
;! "
set# &
;& '
}( )
public 
byte 
[ 
] 
PasswordHash "
{# $
get% (
;( )
set* -
;- .
}/ 0
public 
byte 
[ 
] 
PasswordSalt "
{# $
get% (
;( )
set* -
;- .
}/ 0
public 
byte 
[ 
] 
AuthSalt 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 
byte 
[ 
] 
RecoverySalt "
{# $
get% (
;( )
set* -
;- .
}/ 0
public 
Location 
Location  
{! "
get# &
;& '
set( +
;+ ,
}- .
[ 	
Required	 
] 
public 
UserRole 
Role 
{ 
get "
;" #
set$ '
;' (
}) *
public 
User 
( 
) 
{ 
} 
public!! 
User!! 
(!! 
string!! 
name!! 
,!!  
string!!! '
email!!( -
,!!- .
string!!/ 5
password!!6 >
,!!> ?
Location!!@ H
location!!I Q
,!!Q R
UserRole!!S [
role!!\ `
)!!` a
{"" 	
Name## 
=## 
name## 
;## 
Email$$ 
=$$ 
email$$ 
;$$ 
if%% 
(%% 
password%% 
==%% 
null%%  
)%%  !
throw&& 
new&& !
ArgumentNullException&& /
(&&/ 0
$str&&0 :
)&&: ;
;&&; <
if'' 
('' 
string'' 
.'' 
IsNullOrWhiteSpace'' )
('') *
password''* 2
)''2 3
)''3 4
throw(( 
new(( 
ArgumentException(( +
(((+ ,
$str((, ^
,((^ _
$str((` j
)((j k
;((k l
var)) 
hmac)) 
=)) 
new)) 
System)) !
.))! "
Security))" *
.))* +
Cryptography))+ 7
.))7 8

HMACSHA512))8 B
())B C
)))C D
;))D E
PasswordHash** 
=** 
hmac** 
.**  
ComputeHash**  +
(**+ ,
System**, 2
.**2 3
Text**3 7
.**7 8
Encoding**8 @
.**@ A
UTF8**A E
.**E F
GetBytes**F N
(**N O
password**O W
)**W X
)**X Y
;**Y Z
PasswordSalt++ 
=++ 
hmac++ 
.++  
Key++  #
;++# $
AuthSalt,, 
=,, 
null,, 
;,, 
RecoverySalt-- 
=-- 
null-- 
;--  
Location.. 
=.. 
location.. 
;..  
Role// 
=// 
role// 
;// 
}00 	
}11 
}22 ¢
õ/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Entities/UserRole.cs
	namespace 	
glovo_webapi
 
. 
Utils 
{ 
public 

enum 
UserRole 
{ 
Regular 
, 
Administrator 
} 
} ¥
¥/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Migrations/20201027003800_InitialMigration.cs
	namespace 	
glovo_webapi
 
. 

Migrations !
{ 
public 

partial 
class 
InitialMigration )
:* +
	Migration, 5
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{		 	
migrationBuilder

 
.

 
CreateTable

 (
(

( )
name 
: 
$str #
,# $
columns 
: 
table 
=> !
new" %
{ 
Id 
= 
table 
. 
Column %
<% &
int& )
>) *
(* +
type+ /
:/ 0
$str1 :
,: ;
nullable< D
:D E
falseF K
)K L
. 

Annotation #
(# $
$str$ D
,D E)
NpgsqlValueGenerationStrategyF c
.c d#
IdentityByDefaultColumnd {
){ |
,| }
Name 
= 
table  
.  !
Column! '
<' (
string( .
>. /
(/ 0
type0 4
:4 5
$str6 <
,< =
nullable> F
:F G
falseH M
)M N
,N O
ImgPath 
= 
table #
.# $
Column$ *
<* +
string+ 1
>1 2
(2 3
type3 7
:7 8
$str9 ?
,? @
nullableA I
:I J
trueK O
)O P
} 
, 
constraints 
: 
table "
=># %
{ 
table 
. 

PrimaryKey $
($ %
$str% 5
,5 6
x7 8
=>9 ;
x< =
.= >
Id> @
)@ A
;A B
} 
) 
; 
} 	
	protected 
override 
void 
Down  $
($ %
MigrationBuilder% 5
migrationBuilder6 F
)F G
{ 	
migrationBuilder 
. 
	DropTable &
(& '
name 
: 
$str #
)# $
;$ %
} 	
} 
} ◊
µ/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Migrations/20201030213552_InitialMigration2.cs
	namespace 	
glovo_webapi
 
. 

Migrations !
{ 
public 

partial 
class 
InitialMigration2 *
:+ ,
	Migration- 6
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
}

 	
	protected 
override 
void 
Down  $
($ %
MigrationBuilder% 5
migrationBuilder6 F
)F G
{ 	
} 	
} 
} ú
µ/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Migrations/20201101001222_MigrationProducts.cs
	namespace 	
glovo_webapi
 
. 

Migrations !
{ 
public 

partial 
class 
MigrationProducts *
:+ ,
	Migration- 6
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{		 	
migrationBuilder

 
.

 
CreateTable

 (
(

( )
name 
: 
$str  
,  !
columns 
: 
table 
=> !
new" %
{ 
Id 
= 
table 
. 
Column %
<% &
int& )
>) *
(* +
type+ /
:/ 0
$str1 :
,: ;
nullable< D
:D E
falseF K
)K L
. 

Annotation #
(# $
$str$ D
,D E)
NpgsqlValueGenerationStrategyF c
.c d#
IdentityByDefaultColumnd {
){ |
,| }
Name 
= 
table  
.  !
Column! '
<' (
string( .
>. /
(/ 0
type0 4
:4 5
$str6 <
,< =
nullable> F
:F G
falseH M
)M N
,N O
ImgPath 
= 
table #
.# $
Column$ *
<* +
string+ 1
>1 2
(2 3
type3 7
:7 8
$str9 ?
,? @
nullableA I
:I J
trueK O
)O P
,P Q
Description 
=  !
table" '
.' (
Column( .
<. /
string/ 5
>5 6
(6 7
type7 ;
:; <
$str= C
,C D
nullableE M
:M N
trueO S
)S T
,T U
Price 
= 
table !
.! "
Column" (
<( )
float) .
>. /
(/ 0
type0 4
:4 5
$str6 <
,< =
nullable> F
:F G
falseH M
)M N
} 
, 
constraints 
: 
table "
=># %
{ 
table 
. 

PrimaryKey $
($ %
$str% 2
,2 3
x4 5
=>6 8
x9 :
.: ;
Id; =
)= >
;> ?
} 
) 
; 
} 	
	protected 
override 
void 
Down  $
($ %
MigrationBuilder% 5
migrationBuilder6 F
)F G
{ 	
migrationBuilder 
. 
	DropTable &
(& '
name 
: 
$str  
)  !
;! "
} 	
}   
}!! ”
≤/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Migrations/20201101164712_UsersMigration.cs
	namespace 	
glovo_webapi
 
. 

Migrations !
{ 
public 

partial 
class 
UsersMigration '
:( )
	Migration* 3
{ 
	protected		 
override		 
void		 
Up		  "
(		" #
MigrationBuilder		# 3
migrationBuilder		4 D
)		D E
{

 	
migrationBuilder 
. 
CreateTable (
(( )
name 
: 
$str 
, 
columns 
: 
table 
=> !
new" %
{ 
Id 
= 
table 
. 
Column %
<% &
int& )
>) *
(* +
type+ /
:/ 0
$str1 :
,: ;
nullable< D
:D E
falseF K
)K L
. 

Annotation #
(# $
$str$ D
,D E)
NpgsqlValueGenerationStrategyF c
.c d#
IdentityByDefaultColumnd {
){ |
,| }
Name 
= 
table  
.  !
Column! '
<' (
string( .
>. /
(/ 0
type0 4
:4 5
$str6 <
,< =
nullable> F
:F G
trueH L
)L M
,M N
Email 
= 
table !
.! "
Column" (
<( )
string) /
>/ 0
(0 1
type1 5
:5 6
$str7 =
,= >
nullable? G
:G H
trueI M
)M N
,N O
PasswordHash  
=! "
table# (
.( )
Column) /
</ 0
byte0 4
[4 5
]5 6
>6 7
(7 8
type8 <
:< =
$str> E
,E F
nullableG O
:O P
trueQ U
)U V
,V W
PasswordSalt  
=! "
table# (
.( )
Column) /
</ 0
byte0 4
[4 5
]5 6
>6 7
(7 8
type8 <
:< =
$str> E
,E F
nullableG O
:O P
trueQ U
)U V
} 
, 
constraints 
: 
table "
=># %
{ 
table 
. 

PrimaryKey $
($ %
$str% /
,/ 0
x1 2
=>3 5
x6 7
.7 8
Id8 :
): ;
;; <
} 
) 
; 
} 	
	protected 
override 
void 
Down  $
($ %
MigrationBuilder% 5
migrationBuilder6 F
)F G
{ 	
migrationBuilder 
. 
	DropTable &
(& '
name 
: 
$str 
) 
; 
}   	
}!! 
}"" ¿
¡/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Migrations/20201101183159_MigrationProductsOfRestaurant.cs
	namespace 	
glovo_webapi
 
. 

Migrations !
{ 
public 

partial 
class )
MigrationProductsOfRestaurant 6
:7 8
	Migration9 B
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder		 
.		 
	AddColumn		 &
<		& '
int		' *
>		* +
(		+ ,
name

 
:

 
$str

 
,

 
table 
: 
$str !
,! "
type 
: 
$str 
,  
nullable 
: 
false 
,  
defaultValue 
: 
$num 
)  
;  !
} 	
	protected 
override 
void 
Down  $
($ %
MigrationBuilder% 5
migrationBuilder6 F
)F G
{ 	
migrationBuilder 
. 

DropColumn '
(' (
name 
: 
$str 
, 
table 
: 
$str !
)! "
;" #
} 	
} 
} ¡
™/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Migrations/20201103094826_Deploy.cs
	namespace 	
glovo_webapi
 
. 

Migrations !
{ 
public 

partial 
class 
Deploy 
:  !
	Migration" +
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
}

 	
	protected 
override 
void 
Down  $
($ %
MigrationBuilder% 5
migrationBuilder6 F
)F G
{ 	
} 	
} 
} Ó
≤/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Migrations/20201105183408_ProductsUpdate.cs
	namespace 	
glovo_webapi
 
. 

Migrations !
{ 
public 

partial 
class 
ProductsUpdate '
:( )
	Migration* 3
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder		 
.		 
RenameColumn		 )
(		) *
name

 
:

 
$str

 
,

 
table 
: 
$str !
,! "
newName 
: 
$str !
)! "
;" #
migrationBuilder 
. 
CreateIndex (
(( )
name 
: 
$str *
,* +
table 
: 
$str !
,! "
column 
: 
$str  
)  !
;! "
migrationBuilder 
. 
AddForeignKey *
(* +
name 
: 
$str 6
,6 7
table 
: 
$str !
,! "
column 
: 
$str  
,  !
principalTable 
: 
$str  -
,- .
principalColumn 
:  
$str! %
,% &
onDelete 
: 
ReferentialAction +
.+ ,
Cascade, 3
)3 4
;4 5
} 	
	protected 
override 
void 
Down  $
($ %
MigrationBuilder% 5
migrationBuilder6 F
)F G
{ 	
migrationBuilder 
. 
DropForeignKey +
(+ ,
name 
: 
$str 6
,6 7
table   
:   
$str   !
)  ! "
;  " #
migrationBuilder"" 
."" 
	DropIndex"" &
(""& '
name## 
:## 
$str## *
,##* +
table$$ 
:$$ 
$str$$ !
)$$! "
;$$" #
migrationBuilder&& 
.&& 
RenameColumn&& )
(&&) *
name'' 
:'' 
$str'' 
,'' 
table(( 
:(( 
$str(( !
,((! "
newName)) 
:)) 
$str)) !
)))! "
;))" #
}** 	
}++ 
},, „
≥/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Migrations/20201105192026_ProductsUpdate2.cs
	namespace 	
glovo_webapi
 
. 

Migrations !
{ 
public 

partial 
class 
ProductsUpdate2 (
:) *
	Migration+ 4
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder		 
.		 
DropForeignKey		 +
(		+ ,
name

 
:

 
$str

 6
,

6 7
table 
: 
$str !
)! "
;" #
migrationBuilder 
. 
RenameColumn )
() *
name 
: 
$str 
, 
table 
: 
$str !
,! "
newName 
: 
$str '
)' (
;( )
migrationBuilder 
. 
RenameIndex (
(( )
name 
: 
$str *
,* +
table 
: 
$str !
,! "
newName 
: 
$str 3
)3 4
;4 5
migrationBuilder 
. 
AddForeignKey *
(* +
name 
: 
$str <
,< =
table 
: 
$str !
,! "
column 
: 
$str &
,& '
principalTable 
: 
$str  -
,- .
principalColumn 
:  
$str! %
,% &
onDelete 
: 
ReferentialAction +
.+ ,
Cascade, 3
)3 4
;4 5
} 	
	protected   
override   
void   
Down    $
(  $ %
MigrationBuilder  % 5
migrationBuilder  6 F
)  F G
{!! 	
migrationBuilder"" 
."" 
DropForeignKey"" +
(""+ ,
name## 
:## 
$str## <
,##< =
table$$ 
:$$ 
$str$$ !
)$$! "
;$$" #
migrationBuilder&& 
.&& 
RenameColumn&& )
(&&) *
name'' 
:'' 
$str'' $
,''$ %
table(( 
:(( 
$str(( !
,((! "
newName)) 
:)) 
$str)) !
)))! "
;))" #
migrationBuilder++ 
.++ 
RenameIndex++ (
(++( )
name,, 
:,, 
$str,, 0
,,,0 1
table-- 
:-- 
$str-- !
,--! "
newName.. 
:.. 
$str.. -
)..- .
;... /
migrationBuilder00 
.00 
AddForeignKey00 *
(00* +
name11 
:11 
$str11 6
,116 7
table22 
:22 
$str22 !
,22! "
column33 
:33 
$str33  
,33  !
principalTable44 
:44 
$str44  -
,44- .
principalColumn55 
:55  
$str55! %
,55% &
onDelete66 
:66 
ReferentialAction66 +
.66+ ,
Cascade66, 3
)663 4
;664 5
}77 	
}88 
}99 Ì4
≥/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Migrations/20201106001913_OrdersMigration.cs
	namespace 	
glovo_webapi
 
. 

Migrations !
{ 
public 

partial 
class 
OrdersMigration (
:) *
	Migration+ 4
{ 
	protected		 
override		 
void		 
Up		  "
(		" #
MigrationBuilder		# 3
migrationBuilder		4 D
)		D E
{

 	
migrationBuilder 
. 
	AddColumn &
<& '
int' *
>* +
(+ ,
name 
: 
$str 
,  
table 
: 
$str !
,! "
type 
: 
$str 
,  
nullable 
: 
true 
) 
;  
migrationBuilder 
. 
CreateTable (
(( )
name 
: 
$str 
, 
columns 
: 
table 
=> !
new" %
{ 
Id 
= 
table 
. 
Column %
<% &
int& )
>) *
(* +
type+ /
:/ 0
$str1 :
,: ;
nullable< D
:D E
falseF K
)K L
. 

Annotation #
(# $
$str$ D
,D E)
NpgsqlValueGenerationStrategyF c
.c d#
IdentityByDefaultColumnd {
){ |
,| }
BuyDateTime 
=  !
table" '
.' (
Column( .
<. /
DateTime/ 7
>7 8
(8 9
type9 =
:= >
$str? \
,\ ]
nullable^ f
:f g
falseh m
)m n
,n o
UserId 
= 
table "
." #
Column# )
<) *
int* -
>- .
(. /
type/ 3
:3 4
$str5 >
,> ?
nullable@ H
:H I
trueJ N
)N O
,O P
RestaurantId  
=! "
table# (
.( )
Column) /
</ 0
int0 3
>3 4
(4 5
type5 9
:9 :
$str; D
,D E
nullableF N
:N O
trueP T
)T U
} 
, 
constraints 
: 
table "
=># %
{ 
table 
. 

PrimaryKey $
($ %
$str% 0
,0 1
x2 3
=>4 6
x7 8
.8 9
Id9 ;
); <
;< =
table 
. 

ForeignKey $
($ %
name 
: 
$str B
,B C
column   
:   
x    !
=>  " $
x  % &
.  & '
RestaurantId  ' 3
,  3 4
principalTable!! &
:!!& '
$str!!( 5
,!!5 6
principalColumn"" '
:""' (
$str"") -
,""- .
onDelete##  
:##  !
ReferentialAction##" 3
.##3 4
Restrict##4 <
)##< =
;##= >
table$$ 
.$$ 

ForeignKey$$ $
($$$ %
name%% 
:%% 
$str%% 6
,%%6 7
column&& 
:&& 
x&&  !
=>&&" $
x&&% &
.&&& '
UserId&&' -
,&&- .
principalTable'' &
:''& '
$str''( /
,''/ 0
principalColumn(( '
:((' (
$str(() -
,((- .
onDelete))  
:))  !
ReferentialAction))" 3
.))3 4
Restrict))4 <
)))< =
;))= >
}** 
)** 
;** 
migrationBuilder,, 
.,, 
CreateIndex,, (
(,,( )
name-- 
:-- 
$str-- +
,--+ ,
table.. 
:.. 
$str.. !
,..! "
column// 
:// 
$str// !
)//! "
;//" #
migrationBuilder11 
.11 
CreateIndex11 (
(11( )
name22 
:22 
$str22 .
,22. /
table33 
:33 
$str33 
,33  
column44 
:44 
$str44 &
)44& '
;44' (
migrationBuilder66 
.66 
CreateIndex66 (
(66( )
name77 
:77 
$str77 (
,77( )
table88 
:88 
$str88 
,88  
column99 
:99 
$str99  
)99  !
;99! "
migrationBuilder;; 
.;; 
AddForeignKey;; *
(;;* +
name<< 
:<< 
$str<< 2
,<<2 3
table== 
:== 
$str== !
,==! "
column>> 
:>> 
$str>> !
,>>! "
principalTable?? 
:?? 
$str??  (
,??( )
principalColumn@@ 
:@@  
$str@@! %
,@@% &
onDeleteAA 
:AA 
ReferentialActionAA +
.AA+ ,
RestrictAA, 4
)AA4 5
;AA5 6
}BB 	
	protectedDD 
overrideDD 
voidDD 
DownDD  $
(DD$ %
MigrationBuilderDD% 5
migrationBuilderDD6 F
)DDF G
{EE 	
migrationBuilderFF 
.FF 
DropForeignKeyFF +
(FF+ ,
nameGG 
:GG 
$strGG 2
,GG2 3
tableHH 
:HH 
$strHH !
)HH! "
;HH" #
migrationBuilderJJ 
.JJ 
	DropTableJJ &
(JJ& '
nameKK 
:KK 
$strKK 
)KK 
;KK  
migrationBuilderMM 
.MM 
	DropIndexMM &
(MM& '
nameNN 
:NN 
$strNN +
,NN+ ,
tableOO 
:OO 
$strOO !
)OO! "
;OO" #
migrationBuilderQQ 
.QQ 

DropColumnQQ '
(QQ' (
nameRR 
:RR 
$strRR 
,RR  
tableSS 
:SS 
$strSS !
)SS! "
;SS" #
}TT 	
}UU 
}VV ì-
¥/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Migrations/20201106004411_OrdersMigration2.cs
	namespace 	
glovo_webapi
 
. 

Migrations !
{ 
public 

partial 
class 
OrdersMigration2 )
:* +
	Migration, 5
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder		 
.		 
DropForeignKey		 +
(		+ ,
name

 
:

 
$str

 2
,

2 3
table 
: 
$str !
)! "
;" #
migrationBuilder 
. 
	DropIndex &
(& '
name 
: 
$str +
,+ ,
table 
: 
$str !
)! "
;" #
migrationBuilder 
. 

DropColumn '
(' (
name 
: 
$str 
,  
table 
: 
$str !
)! "
;" #
migrationBuilder 
. 
CreateTable (
(( )
name 
: 
$str $
,$ %
columns 
: 
table 
=> !
new" %
{ 
OrdersId 
= 
table $
.$ %
Column% +
<+ ,
int, /
>/ 0
(0 1
type1 5
:5 6
$str7 @
,@ A
nullableB J
:J K
falseL Q
)Q R
,R S

ProductsId 
=  
table! &
.& '
Column' -
<- .
int. 1
>1 2
(2 3
type3 7
:7 8
$str9 B
,B C
nullableD L
:L M
falseN S
)S T
} 
, 
constraints 
: 
table "
=># %
{ 
table 
. 

PrimaryKey $
($ %
$str% 6
,6 7
x8 9
=>: <
new= @
{A B
xC D
.D E
OrdersIdE M
,M N
xO P
.P Q

ProductsIdQ [
}\ ]
)] ^
;^ _
table 
. 

ForeignKey $
($ %
name   
:   
$str   ?
,  ? @
column!! 
:!! 
x!!  !
=>!!" $
x!!% &
.!!& '
OrdersId!!' /
,!!/ 0
principalTable"" &
:""& '
$str""( 0
,""0 1
principalColumn## '
:##' (
$str##) -
,##- .
onDelete$$  
:$$  !
ReferentialAction$$" 3
.$$3 4
Cascade$$4 ;
)$$; <
;$$< =
table%% 
.%% 

ForeignKey%% $
(%%$ %
name&& 
:&& 
$str&& C
,&&C D
column'' 
:'' 
x''  !
=>''" $
x''% &
.''& '

ProductsId''' 1
,''1 2
principalTable(( &
:((& '
$str((( 2
,((2 3
principalColumn)) '
:))' (
$str))) -
,))- .
onDelete**  
:**  !
ReferentialAction**" 3
.**3 4
Cascade**4 ;
)**; <
;**< =
}++ 
)++ 
;++ 
migrationBuilder-- 
.-- 
CreateIndex-- (
(--( )
name.. 
:.. 
$str.. 2
,..2 3
table// 
:// 
$str// %
,//% &
column00 
:00 
$str00 $
)00$ %
;00% &
}11 	
	protected33 
override33 
void33 
Down33  $
(33$ %
MigrationBuilder33% 5
migrationBuilder336 F
)33F G
{44 	
migrationBuilder55 
.55 
	DropTable55 &
(55& '
name66 
:66 
$str66 $
)66$ %
;66% &
migrationBuilder88 
.88 
	AddColumn88 &
<88& '
int88' *
>88* +
(88+ ,
name99 
:99 
$str99 
,99  
table:: 
::: 
$str:: !
,::! "
type;; 
:;; 
$str;; 
,;;  
nullable<< 
:<< 
true<< 
)<< 
;<<  
migrationBuilder>> 
.>> 
CreateIndex>> (
(>>( )
name?? 
:?? 
$str?? +
,??+ ,
table@@ 
:@@ 
$str@@ !
,@@! "
columnAA 
:AA 
$strAA !
)AA! "
;AA" #
migrationBuilderCC 
.CC 
AddForeignKeyCC *
(CC* +
nameDD 
:DD 
$strDD 2
,DD2 3
tableEE 
:EE 
$strEE !
,EE! "
columnFF 
:FF 
$strFF !
,FF! "
principalTableGG 
:GG 
$strGG  (
,GG( )
principalColumnHH 
:HH  
$strHH! %
,HH% &
onDeleteII 
:II 
ReferentialActionII +
.II+ ,
RestrictII, 4
)II4 5
;II5 6
}JJ 	
}KK 
}LL Ä7
º/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Migrations/20201106102914_OrdersProductsMigration1.cs
	namespace 	
glovo_webapi
 
. 

Migrations !
{ 
public 

partial 
class $
OrdersProductsMigration1 1
:2 3
	Migration4 =
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder		 
.		 
	DropTable		 &
(		& '
name

 
:

 
$str

 $
)

$ %
;

% &
migrationBuilder 
. 
CreateTable (
(( )
name 
: 
$str &
,& '
columns 
: 
table 
=> !
new" %
{ 
OrderId 
= 
table #
.# $
Column$ *
<* +
int+ .
>. /
(/ 0
type0 4
:4 5
$str6 ?
,? @
nullableA I
:I J
falseK P
)P Q
,Q R
	ProductId 
= 
table  %
.% &
Column& ,
<, -
int- 0
>0 1
(1 2
type2 6
:6 7
$str8 A
,A B
nullableC K
:K L
falseM R
)R S
,S T
Quantity 
= 
table $
.$ %
Column% +
<+ ,
int, /
>/ 0
(0 1
type1 5
:5 6
$str7 @
,@ A
nullableB J
:J K
falseL Q
)Q R
} 
, 
constraints 
: 
table "
=># %
{ 
table 
. 

PrimaryKey $
($ %
$str% 8
,8 9
x: ;
=>< >
new? B
{C D
xE F
.F G
OrderIdG N
,N O
xP Q
.Q R
	ProductIdR [
}\ ]
)] ^
;^ _
table 
. 

ForeignKey $
($ %
name 
: 
$str @
,@ A
column 
: 
x  !
=>" $
x% &
.& '
OrderId' .
,. /
principalTable &
:& '
$str( 0
,0 1
principalColumn '
:' (
$str) -
,- .
onDelete  
:  !
ReferentialAction" 3
.3 4
Cascade4 ;
); <
;< =
table 
. 

ForeignKey $
($ %
name 
: 
$str D
,D E
column 
: 
x  !
=>" $
x% &
.& '
	ProductId' 0
,0 1
principalTable   &
:  & '
$str  ( 2
,  2 3
principalColumn!! '
:!!' (
$str!!) -
,!!- .
onDelete""  
:""  !
ReferentialAction""" 3
.""3 4
Cascade""4 ;
)""; <
;""< =
}## 
)## 
;## 
migrationBuilder%% 
.%% 
CreateIndex%% (
(%%( )
name&& 
:&& 
$str&& 3
,&&3 4
table'' 
:'' 
$str'' '
,''' (
column(( 
:(( 
$str(( #
)((# $
;(($ %
})) 	
	protected++ 
override++ 
void++ 
Down++  $
(++$ %
MigrationBuilder++% 5
migrationBuilder++6 F
)++F G
{,, 	
migrationBuilder-- 
.-- 
	DropTable-- &
(--& '
name.. 
:.. 
$str.. &
)..& '
;..' (
migrationBuilder00 
.00 
CreateTable00 (
(00( )
name11 
:11 
$str11 $
,11$ %
columns22 
:22 
table22 
=>22 !
new22" %
{33 
OrdersId44 
=44 
table44 $
.44$ %
Column44% +
<44+ ,
int44, /
>44/ 0
(440 1
type441 5
:445 6
$str447 @
,44@ A
nullable44B J
:44J K
false44L Q
)44Q R
,44R S

ProductsId55 
=55  
table55! &
.55& '
Column55' -
<55- .
int55. 1
>551 2
(552 3
type553 7
:557 8
$str559 B
,55B C
nullable55D L
:55L M
false55N S
)55S T
}66 
,66 
constraints77 
:77 
table77 "
=>77# %
{88 
table99 
.99 

PrimaryKey99 $
(99$ %
$str99% 6
,996 7
x998 9
=>99: <
new99= @
{99A B
x99C D
.99D E
OrdersId99E M
,99M N
x99O P
.99P Q

ProductsId99Q [
}99\ ]
)99] ^
;99^ _
table:: 
.:: 

ForeignKey:: $
(::$ %
name;; 
:;; 
$str;; ?
,;;? @
column<< 
:<< 
x<<  !
=><<" $
x<<% &
.<<& '
OrdersId<<' /
,<</ 0
principalTable== &
:==& '
$str==( 0
,==0 1
principalColumn>> '
:>>' (
$str>>) -
,>>- .
onDelete??  
:??  !
ReferentialAction??" 3
.??3 4
Cascade??4 ;
)??; <
;??< =
table@@ 
.@@ 

ForeignKey@@ $
(@@$ %
nameAA 
:AA 
$strAA C
,AAC D
columnBB 
:BB 
xBB  !
=>BB" $
xBB% &
.BB& '

ProductsIdBB' 1
,BB1 2
principalTableCC &
:CC& '
$strCC( 2
,CC2 3
principalColumnDD '
:DD' (
$strDD) -
,DD- .
onDeleteEE  
:EE  !
ReferentialActionEE" 3
.EE3 4
CascadeEE4 ;
)EE; <
;EE< =
}FF 
)FF 
;FF 
migrationBuilderHH 
.HH 
CreateIndexHH (
(HH( )
nameII 
:II 
$strII 2
,II2 3
tableJJ 
:JJ 
$strJJ %
,JJ% &
columnKK 
:KK 
$strKK $
)KK$ %
;KK% &
}LL 	
}MM 
}NN Â
º/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Migrations/20201106125508_OrdersProductsMigration2.cs
	namespace 	
glovo_webapi
 
. 

Migrations !
{ 
public 

partial 
class $
OrdersProductsMigration2 1
:2 3
	Migration4 =
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
}

 	
	protected 
override 
void 
Down  $
($ %
MigrationBuilder% 5
migrationBuilder6 F
)F G
{ 	
} 	
} 
} ®
µ/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Migrations/20201106183230_ProductCategories.cs
	namespace 	
glovo_webapi
 
. 

Migrations !
{ 
public 

partial 
class 
ProductCategories *
:+ ,
	Migration- 6
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder		 
.		 
	AddColumn		 &
<		& '
int		' *
>		* +
(		+ ,
name

 
:

 
$str

  
,

  !
table 
: 
$str !
,! "
type 
: 
$str 
,  
nullable 
: 
false 
,  
defaultValue 
: 
$num 
)  
;  !
} 	
	protected 
override 
void 
Down  $
($ %
MigrationBuilder% 5
migrationBuilder6 F
)F G
{ 	
migrationBuilder 
. 

DropColumn '
(' (
name 
: 
$str  
,  !
table 
: 
$str !
)! "
;" #
} 	
} 
} µ5
Ω/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Migrations/20201108002934_NewOrderProductsMigration.cs
	namespace 	
glovo_webapi
 
. 

Migrations !
{ 
public 

partial 
class %
NewOrderProductsMigration 2
:3 4
	Migration5 >
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder		 
.		 
DropForeignKey		 +
(		+ ,
name

 
:

 
$str

 :
,

: ;
table 
: 
$str 
)  
;  !
migrationBuilder 
. 
DropForeignKey +
(+ ,
name 
: 
$str .
,. /
table 
: 
$str 
)  
;  !
migrationBuilder 
. 
AlterColumn (
<( )
int) ,
>, -
(- .
name 
: 
$str 
, 
table 
: 
$str 
,  
type 
: 
$str 
,  
nullable 
: 
false 
,  
defaultValue 
: 
$num 
,  

oldClrType 
: 
typeof "
(" #
int# &
)& '
,' (
oldType 
: 
$str "
," #
oldNullable 
: 
true !
)! "
;" #
migrationBuilder 
. 
AlterColumn (
<( )
int) ,
>, -
(- .
name 
: 
$str $
,$ %
table 
: 
$str 
,  
type 
: 
$str 
,  
nullable 
: 
false 
,  
defaultValue   
:   
$num   
,    

oldClrType!! 
:!! 
typeof!! "
(!!" #
int!!# &
)!!& '
,!!' (
oldType"" 
:"" 
$str"" "
,""" #
oldNullable## 
:## 
true## !
)##! "
;##" #
migrationBuilder%% 
.%% 
AddForeignKey%% *
(%%* +
name&& 
:&& 
$str&& :
,&&: ;
table'' 
:'' 
$str'' 
,''  
column(( 
:(( 
$str(( &
,((& '
principalTable)) 
:)) 
$str))  -
,))- .
principalColumn** 
:**  
$str**! %
,**% &
onDelete++ 
:++ 
ReferentialAction++ +
.+++ ,
Cascade++, 3
)++3 4
;++4 5
migrationBuilder-- 
.-- 
AddForeignKey-- *
(--* +
name.. 
:.. 
$str.. .
,... /
table// 
:// 
$str// 
,//  
column00 
:00 
$str00  
,00  !
principalTable11 
:11 
$str11  '
,11' (
principalColumn22 
:22  
$str22! %
,22% &
onDelete33 
:33 
ReferentialAction33 +
.33+ ,
Cascade33, 3
)333 4
;334 5
}44 	
	protected66 
override66 
void66 
Down66  $
(66$ %
MigrationBuilder66% 5
migrationBuilder666 F
)66F G
{77 	
migrationBuilder88 
.88 
DropForeignKey88 +
(88+ ,
name99 
:99 
$str99 :
,99: ;
table:: 
::: 
$str:: 
)::  
;::  !
migrationBuilder<< 
.<< 
DropForeignKey<< +
(<<+ ,
name== 
:== 
$str== .
,==. /
table>> 
:>> 
$str>> 
)>>  
;>>  !
migrationBuilder@@ 
.@@ 
AlterColumn@@ (
<@@( )
int@@) ,
>@@, -
(@@- .
nameAA 
:AA 
$strAA 
,AA 
tableBB 
:BB 
$strBB 
,BB  
typeCC 
:CC 
$strCC 
,CC  
nullableDD 
:DD 
trueDD 
,DD 

oldClrTypeEE 
:EE 
typeofEE "
(EE" #
intEE# &
)EE& '
,EE' (
oldTypeFF 
:FF 
$strFF "
)FF" #
;FF# $
migrationBuilderHH 
.HH 
AlterColumnHH (
<HH( )
intHH) ,
>HH, -
(HH- .
nameII 
:II 
$strII $
,II$ %
tableJJ 
:JJ 
$strJJ 
,JJ  
typeKK 
:KK 
$strKK 
,KK  
nullableLL 
:LL 
trueLL 
,LL 

oldClrTypeMM 
:MM 
typeofMM "
(MM" #
intMM# &
)MM& '
,MM' (
oldTypeNN 
:NN 
$strNN "
)NN" #
;NN# $
migrationBuilderPP 
.PP 
AddForeignKeyPP *
(PP* +
nameQQ 
:QQ 
$strQQ :
,QQ: ;
tableRR 
:RR 
$strRR 
,RR  
columnSS 
:SS 
$strSS &
,SS& '
principalTableTT 
:TT 
$strTT  -
,TT- .
principalColumnUU 
:UU  
$strUU! %
,UU% &
onDeleteVV 
:VV 
ReferentialActionVV +
.VV+ ,
RestrictVV, 4
)VV4 5
;VV5 6
migrationBuilderXX 
.XX 
AddForeignKeyXX *
(XX* +
nameYY 
:YY 
$strYY .
,YY. /
tableZZ 
:ZZ 
$strZZ 
,ZZ  
column[[ 
:[[ 
$str[[  
,[[  !
principalTable\\ 
:\\ 
$str\\  '
,\\' (
principalColumn]] 
:]]  
$str]]! %
,]]% &
onDelete^^ 
:^^ 
ReferentialAction^^ +
.^^+ ,
Restrict^^, 4
)^^4 5
;^^5 6
}__ 	
}`` 
}aa °5
≥/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Migrations/20201112140842_RebaseMigration.cs
	namespace 	
glovo_webapi
 
. 

Migrations !
{ 
public 

partial 
class 
RebaseMigration (
:) *
	Migration+ 4
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder		 
.		 
DropForeignKey		 +
(		+ ,
name

 
:

 
$str

 :
,

: ;
table 
: 
$str 
)  
;  !
migrationBuilder 
. 
DropForeignKey +
(+ ,
name 
: 
$str .
,. /
table 
: 
$str 
)  
;  !
migrationBuilder 
. 
AlterColumn (
<( )
int) ,
>, -
(- .
name 
: 
$str 
, 
table 
: 
$str 
,  
type 
: 
$str 
,  
nullable 
: 
false 
,  
defaultValue 
: 
$num 
,  

oldClrType 
: 
typeof "
(" #
int# &
)& '
,' (
oldType 
: 
$str "
," #
oldNullable 
: 
true !
)! "
;" #
migrationBuilder 
. 
AlterColumn (
<( )
int) ,
>, -
(- .
name 
: 
$str $
,$ %
table 
: 
$str 
,  
type 
: 
$str 
,  
nullable 
: 
false 
,  
defaultValue   
:   
$num   
,    

oldClrType!! 
:!! 
typeof!! "
(!!" #
int!!# &
)!!& '
,!!' (
oldType"" 
:"" 
$str"" "
,""" #
oldNullable## 
:## 
true## !
)##! "
;##" #
migrationBuilder%% 
.%% 
AddForeignKey%% *
(%%* +
name&& 
:&& 
$str&& :
,&&: ;
table'' 
:'' 
$str'' 
,''  
column(( 
:(( 
$str(( &
,((& '
principalTable)) 
:)) 
$str))  -
,))- .
principalColumn** 
:**  
$str**! %
,**% &
onDelete++ 
:++ 
ReferentialAction++ +
.+++ ,
Cascade++, 3
)++3 4
;++4 5
migrationBuilder-- 
.-- 
AddForeignKey-- *
(--* +
name.. 
:.. 
$str.. .
,... /
table// 
:// 
$str// 
,//  
column00 
:00 
$str00  
,00  !
principalTable11 
:11 
$str11  '
,11' (
principalColumn22 
:22  
$str22! %
,22% &
onDelete33 
:33 
ReferentialAction33 +
.33+ ,
Cascade33, 3
)333 4
;334 5
}55 	
	protected77 
override77 
void77 
Down77  $
(77$ %
MigrationBuilder77% 5
migrationBuilder776 F
)77F G
{88 	
migrationBuilder99 
.99 
DropForeignKey99 +
(99+ ,
name:: 
::: 
$str:: :
,::: ;
table;; 
:;; 
$str;; 
);;  
;;;  !
migrationBuilder== 
.== 
DropForeignKey== +
(==+ ,
name>> 
:>> 
$str>> .
,>>. /
table?? 
:?? 
$str?? 
)??  
;??  !
migrationBuilderAA 
.AA 
AlterColumnAA (
<AA( )
intAA) ,
>AA, -
(AA- .
nameBB 
:BB 
$strBB 
,BB 
tableCC 
:CC 
$strCC 
,CC  
typeDD 
:DD 
$strDD 
,DD  
nullableEE 
:EE 
trueEE 
,EE 

oldClrTypeFF 
:FF 
typeofFF "
(FF" #
intFF# &
)FF& '
,FF' (
oldTypeGG 
:GG 
$strGG "
)GG" #
;GG# $
migrationBuilderII 
.II 
AlterColumnII (
<II( )
intII) ,
>II, -
(II- .
nameJJ 
:JJ 
$strJJ $
,JJ$ %
tableKK 
:KK 
$strKK 
,KK  
typeLL 
:LL 
$strLL 
,LL  
nullableMM 
:MM 
trueMM 
,MM 

oldClrTypeNN 
:NN 
typeofNN "
(NN" #
intNN# &
)NN& '
,NN' (
oldTypeOO 
:OO 
$strOO "
)OO" #
;OO# $
migrationBuilderQQ 
.QQ 
AddForeignKeyQQ *
(QQ* +
nameRR 
:RR 
$strRR :
,RR: ;
tableSS 
:SS 
$strSS 
,SS  
columnTT 
:TT 
$strTT &
,TT& '
principalTableUU 
:UU 
$strUU  -
,UU- .
principalColumnVV 
:VV  
$strVV! %
,VV% &
onDeleteWW 
:WW 
ReferentialActionWW +
.WW+ ,
RestrictWW, 4
)WW4 5
;WW5 6
migrationBuilderYY 
.YY 
AddForeignKeyYY *
(YY* +
nameZZ 
:ZZ 
$strZZ .
,ZZ. /
table[[ 
:[[ 
$str[[ 
,[[  
column\\ 
:\\ 
$str\\  
,\\  !
principalTable]] 
:]] 
$str]]  '
,]]' (
principalColumn^^ 
:^^  
$str^^! %
,^^% &
onDelete__ 
:__ 
ReferentialAction__ +
.__+ ,
Restrict__, 4
)__4 5
;__5 6
}`` 	
}aa 
}bb ’
¥/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Migrations/20201112141446_RebaseMigration2.cs
	namespace 	
glovo_webapi
 
. 

Migrations !
{ 
public 

partial 
class 
RebaseMigration2 )
:* +
	Migration, 5
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
}

 	
	protected 
override 
void 
Down  $
($ %
MigrationBuilder% 5
migrationBuilder6 F
)F G
{ 	
} 	
} 
} Í
¨/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Migrations/20201118150935_AuthSalt.cs
	namespace 	
glovo_webapi
 
. 

Migrations !
{ 
public 

partial 
class 
AuthSalt !
:" #
	Migration$ -
{ 
	protected		 
override		 
void		 
Up		  "
(		" #
MigrationBuilder		# 3
migrationBuilder		4 D
)		D E
{

 	
migrationBuilder 
. 
	AddColumn &
<& '
byte' +
[+ ,
], -
>- .
(. /
name 
: 
$str  
,  !
table 
: 
$str 
, 
type 
: 
$str 
, 
nullable 
: 
true 
) 
;  
} 	
	protected 
override 
void 
Down  $
($ %
MigrationBuilder% 5
migrationBuilder6 F
)F G
{ 	
migrationBuilder 
. 

DropColumn '
(' (
name 
: 
$str  
,  !
table 
: 
$str 
) 
;  
} 	
} 
} ñ
¨/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Migrations/20201119175956_UserRole.cs
	namespace 	
glovo_webapi
 
. 

Migrations !
{ 
public 

partial 
class 
UserRole !
:" #
	Migration$ -
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder		 
.		 
	AddColumn		 &
<		& '
int		' *
>		* +
(		+ ,
name

 
:

 
$str

 
,

 
table 
: 
$str 
, 
type 
: 
$str 
,  
nullable 
: 
false 
,  
defaultValue 
: 
$num 
)  
;  !
} 	
	protected 
override 
void 
Down  $
($ %
MigrationBuilder% 5
migrationBuilder6 F
)F G
{ 	
migrationBuilder 
. 

DropColumn '
(' (
name 
: 
$str 
, 
table 
: 
$str 
) 
;  
} 	
} 
} È
µ/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Migrations/20201120195624_LocationMigration.cs
	namespace 	
glovo_webapi
 
. 

Migrations !
{ 
public 

partial 
class 
LocationMigration *
:+ ,
	Migration- 6
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder		 
.		 
	AddColumn		 &
<		& '
double		' -
>		- .
(		. /
name

 
:

 
$str

 #
,

# $
table 
: 
$str 
, 
type 
: 
$str (
,( )
nullable 
: 
true 
) 
;  
migrationBuilder 
. 
	AddColumn &
<& '
double' -
>- .
(. /
name 
: 
$str $
,$ %
table 
: 
$str 
, 
type 
: 
$str (
,( )
nullable 
: 
true 
) 
;  
} 	
	protected 
override 
void 
Down  $
($ %
MigrationBuilder% 5
migrationBuilder6 F
)F G
{ 	
migrationBuilder 
. 

DropColumn '
(' (
name 
: 
$str #
,# $
table 
: 
$str 
) 
;  
migrationBuilder 
. 

DropColumn '
(' (
name 
: 
$str $
,$ %
table 
: 
$str 
) 
;  
} 	
}   
}!! ˇ
¿/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Migrations/20201124074450_RestaurantsLocationMigration.cs
	namespace 	
glovo_webapi
 
. 

Migrations !
{ 
public 

partial 
class (
RestaurantsLocationMigration 5
:6 7
	Migration8 A
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder		 
.		 
	AddColumn		 &
<		& '
double		' -
>		- .
(		. /
name

 
:

 
$str

 #
,

# $
table 
: 
$str $
,$ %
type 
: 
$str (
,( )
nullable 
: 
true 
) 
;  
migrationBuilder 
. 
	AddColumn &
<& '
double' -
>- .
(. /
name 
: 
$str $
,$ %
table 
: 
$str $
,$ %
type 
: 
$str (
,( )
nullable 
: 
true 
) 
;  
} 	
	protected 
override 
void 
Down  $
($ %
MigrationBuilder% 5
migrationBuilder6 F
)F G
{ 	
migrationBuilder 
. 

DropColumn '
(' (
name 
: 
$str #
,# $
table 
: 
$str $
)$ %
;% &
migrationBuilder 
. 

DropColumn '
(' (
name 
: 
$str $
,$ %
table 
: 
$str $
)$ %
;% &
} 	
}   
}!! Ÿ
∫/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Migrations/20201125231556_LocationClassMigration.cs
	namespace 	
glovo_webapi
 
. 

Migrations !
{ 
public 

partial 
class "
LocationClassMigration /
:0 1
	Migration2 ;
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder		 
.		 
RenameColumn		 )
(		) *
name

 
:

 
$str

 $
,

$ %
table 
: 
$str 
, 
newName 
: 
$str -
)- .
;. /
migrationBuilder 
. 
RenameColumn )
() *
name 
: 
$str #
,# $
table 
: 
$str 
, 
newName 
: 
$str ,
), -
;- .
migrationBuilder 
. 
RenameColumn )
() *
name 
: 
$str $
,$ %
table 
: 
$str $
,$ %
newName 
: 
$str -
)- .
;. /
migrationBuilder 
. 
RenameColumn )
() *
name 
: 
$str #
,# $
table 
: 
$str $
,$ %
newName 
: 
$str ,
), -
;- .
} 	
	protected 
override 
void 
Down  $
($ %
MigrationBuilder% 5
migrationBuilder6 F
)F G
{ 	
migrationBuilder   
.   
RenameColumn   )
(  ) *
name!! 
:!! 
$str!! *
,!!* +
table"" 
:"" 
$str"" 
,"" 
newName## 
:## 
$str## '
)##' (
;##( )
migrationBuilder%% 
.%% 
RenameColumn%% )
(%%) *
name&& 
:&& 
$str&& )
,&&) *
table'' 
:'' 
$str'' 
,'' 
newName(( 
:(( 
$str(( &
)((& '
;((' (
migrationBuilder** 
.** 
RenameColumn** )
(**) *
name++ 
:++ 
$str++ *
,++* +
table,, 
:,, 
$str,, $
,,,$ %
newName-- 
:-- 
$str-- '
)--' (
;--( )
migrationBuilder// 
.// 
RenameColumn// )
(//) *
name00 
:00 
$str00 )
,00) *
table11 
:11 
$str11 $
,11$ %
newName22 
:22 
$str22 &
)22& '
;22' (
}33 	
}44 
}55 ¸
µ/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Migrations/20201129015426_PwdRecovMigration.cs
	namespace 	
glovo_webapi
 
. 

Migrations !
{ 
public 

partial 
class 
PwdRecovMigration *
:+ ,
	Migration- 6
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{		 	
migrationBuilder

 
.

 
	AddColumn

 &
<

& '
byte

' +
[

+ ,
]

, -
>

- .
(

. /
name 
: 
$str $
,$ %
table 
: 
$str 
, 
type 
: 
$str 
, 
nullable 
: 
true 
) 
;  
} 	
	protected 
override 
void 
Down  $
($ %
MigrationBuilder% 5
migrationBuilder6 F
)F G
{ 	
migrationBuilder 
. 

DropColumn '
(' (
name 
: 
$str $
,$ %
table 
: 
$str 
) 
;  
} 	
} 
} ì
∑/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Migrations/20201130131050_ConstraintMigration.cs
	namespace 	
glovo_webapi
 
. 

Migrations !
{ 
public 

partial 
class 
ConstraintMigration ,
:- .
	Migration/ 8
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder		 
.		 
AlterColumn		 (
<		( )
double		) /
>		/ 0
(		0 1
name

 
:

 
$str

 *
,

* +
table 
: 
$str $
,$ %
type 
: 
$str (
,( )
nullable 
: 
false 
,  
defaultValue 
: 
$num !
,! "

oldClrType 
: 
typeof "
(" #
double# )
)) *
,* +
oldType 
: 
$str +
,+ ,
oldNullable 
: 
true !
)! "
;" #
migrationBuilder 
. 
AlterColumn (
<( )
double) /
>/ 0
(0 1
name 
: 
$str )
,) *
table 
: 
$str $
,$ %
type 
: 
$str (
,( )
nullable 
: 
false 
,  
defaultValue 
: 
$num !
,! "

oldClrType 
: 
typeof "
(" #
double# )
)) *
,* +
oldType 
: 
$str +
,+ ,
oldNullable 
: 
true !
)! "
;" #
} 	
	protected 
override 
void 
Down  $
($ %
MigrationBuilder% 5
migrationBuilder6 F
)F G
{ 	
migrationBuilder   
.   
AlterColumn   (
<  ( )
double  ) /
>  / 0
(  0 1
name!! 
:!! 
$str!! *
,!!* +
table"" 
:"" 
$str"" $
,""$ %
type## 
:## 
$str## (
,##( )
nullable$$ 
:$$ 
true$$ 
,$$ 

oldClrType%% 
:%% 
typeof%% "
(%%" #
double%%# )
)%%) *
,%%* +
oldType&& 
:&& 
$str&& +
)&&+ ,
;&&, -
migrationBuilder(( 
.(( 
AlterColumn(( (
<((( )
double(() /
>((/ 0
(((0 1
name)) 
:)) 
$str)) )
,))) *
table** 
:** 
$str** $
,**$ %
type++ 
:++ 
$str++ (
,++( )
nullable,, 
:,, 
true,, 
,,, 

oldClrType-- 
:-- 
typeof-- "
(--" #
double--# )
)--) *
,--* +
oldType.. 
:.. 
$str.. +
)..+ ,
;.., -
}// 	
}00 
}11 ﬂ
π/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Migrations/20201130140115_ConstraintsMigration2.cs
	namespace 	
glovo_webapi
 
. 

Migrations !
{ 
public 

partial 
class !
ConstraintsMigration2 .
:/ 0
	Migration1 :
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
}

 	
	protected 
override 
void 
Down  $
($ %
MigrationBuilder% 5
migrationBuilder6 F
)F G
{ 	
} 	
} 
} Ì
¿/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Migrations/20201130162359_DoubleKeyAnnotationMigration.cs
	namespace 	
glovo_webapi
 
. 

Migrations !
{ 
public 

partial 
class (
DoubleKeyAnnotationMigration 5
:6 7
	Migration8 A
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
}

 	
	protected 
override 
void 
Down  $
($ %
MigrationBuilder% 5
migrationBuilder6 F
)F G
{ 	
} 	
} 
} ‡
ß/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Models/Location/LocationModel.cs
	namespace 	
glovo_webapi
 
. 
Models 
. 
Location &
{ 
public 

class 
LocationModel 
{ 
[		 	
Required			 
]		 
[

 	
Range

	 
(

 
-

 
$num

 
,

 
$num

 
,

 
ErrorMessage

 $
=

% &
$str

' L
)

L M
]

M N
public 
double 
? 
Latitude 
{  !
get" %
;% &
set' *
;* +
}, -
[ 	
Required	 
] 
[ 	
Range	 
( 
- 
$num 
, 
$num 
, 
ErrorMessage &
=' (
$str) O
)O P
]P Q
public 
double 
? 
	Longitude  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 
LocationModel 
( 
) 
{  
}  !
public 
LocationModel 
( 
double #
latitude$ ,
,, -
double. 4
	longitude5 >
)> ?
{ 	
Latitude 
= 
latitude 
;  
	Longitude 
= 
	longitude !
;! "
} 	
} 
} €	
§/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Models/Order/GetOrderModel.cs
	namespace 	
glovo_webapi
 
. 
Models 
. 
Order #
{ 
public		 

class		 
GetOrderModel		 
{

 
public 
int 
Id 
{ 
get 
; 
set  
;  !
}" #
public 
DateTime 
BuyDateTime #
{$ %
get& )
;) *
set+ .
;. /
}0 1
public 
int 
UserId 
{ 
get 
;  
set! $
;$ %
}& '
public 
int 
RestaurantId 
{  !
get" %
;% &
set' *
;* +
}, -
public 
IEnumerable 
< 
OrderProductModel ,
>, -
Products. 6
{7 8
get9 <
;< =
set> A
;A B
}C D
} 
} ∑

•/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Models/Order/PostOrderModel.cs
	namespace 	
glovo_webapi
 
. 
Models 
. 
Order #
{ 
public		 

class		 
PostOrderModel		 
{

 
[ 	
Required	 
] 
public 
int 
? 
RestaurantId  
{! "
get# &
;& '
set( +
;+ ,
}- .
[ 	
Required	 
] 
public 
IEnumerable 
< 
OrderProductModel ,
>, -
Products. 6
{7 8
get9 <
;< =
set> A
;A B
}C D
public 
PostOrderModel 
( 
int !
restaurantId" .
,. /
IEnumerable0 ;
<; <
OrderProductModel< M
>M N
productsO W
)W X
{ 	
RestaurantId 
= 
restaurantId '
;' (
Products 
= 
products 
;  
} 	
} 
} «	
Ø/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Models/OrderProduct/OrderProductModel.cs
	namespace 	
glovo_webapi
 
. 
Models 
. 
OrderProduct *
{ 
public 

class 
OrderProductModel "
{ 
[		 	
Required			 
]		 
public

 
int

 
?

 
	ProductId

 
{

 
get

  #
;

# $
set

% (
;

( )
}

* +
[ 	
Required	 
] 
public 
int 
? 
Quantity 
{ 
get "
;" #
set$ '
;' (
}) *
public 
OrderProductModel  
(  !
int! $
	productId% .
,. /
int0 3
quantity4 <
)< =
{ 	
	ProductId 
= 
	productId !
;! "
Quantity 
= 
quantity 
;  
} 	
} 
} ¥
•/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Models/Product/ProductModel.cs
	namespace 	
glovo_webapi
 
. 
Models 
. 
Product %
{ 
public 

class 
ProductModel 
{ 
public		 
int		 
Id		 
{		 
get		 
;		 
set		  
;		  !
}		" #
public

 
string

 
Name

 
{

 
get

  
;

  !
set

" %
;

% &
}

' (
public 
string 
ImgPath 
{ 
get  #
;# $
set% (
;( )
}* +
public 
string 
Description !
{" #
get$ '
;' (
set) ,
;, -
}. /
public 
float 
Price 
{ 
get  
;  !
set" %
;% &
}' (
public 
int 
RestaurantId 
{  !
get" %
;% &
set' *
;* +
}, -
public 
ProductCategory 
Category '
{( )
get* -
;- .
set/ 2
;2 3
}4 5
public 
string 
CategoryString $
{ 	
get 
{ 
return 
Category !
.! "
ToString" *
(* +
)+ ,
;, -
}. /
} 	
public 
ProductModel 
( 
int 
id  "
," #
string$ *
name+ /
,/ 0
string1 7
imgPath8 ?
,? @
stringA G
descriptionH S
,S T
floatU Z
price[ `
,` a
intb e
restaurantIdf r
)r s
{ 	
Id 
= 
id 
; 
Name 
= 
name 
; 
ImgPath 
= 
imgPath 
; 
Description 
= 
description %
;% &
Price 
= 
price 
; 
RestaurantId 
= 
restaurantId '
;' (
} 	
} 
}   “	
≥/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Models/Restaurant/DistanceRestaurantModel.cs
	namespace 	
glovo_webapi
 
. 
Models 
. 

Restaurant (
{ 
public 
class #
DistanceRestaurantModel ,
{ 	
public 
int 
Id 
{ 
get  #
;# $
set% (
;( )
}* +
public 
string 
Name "
{# $
get% (
;( )
set* -
;- .
}/ 0
public 
string 
ImgPath %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
public 
double 
? 
Distance '
{( )
get* -
;- .
set/ 2
;2 3
}4 5
public		 
double		 
?		 
DeliveryFee		 *
{		+ ,
get		- 0
;		0 1
set		2 5
;		5 6
}		7 8
}

 	
} ú
≥/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Models/Restaurant/LocationRestaurantModel.cs
	namespace 	
glovo_webapi
 
. 
Models 
. 

Restaurant (
{ 
public 
class #
LocationRestaurantModel ,
{ 	
public 
int 
Id 
{ 
get  #
;# $
set% (
;( )
}* +
public 
string 
Name "
{# $
get% (
;( )
set* -
;- .
}/ 0
public		 
string		 
ImgPath		 %
{		& '
get		( +
;		+ ,
set		- 0
;		0 1
}		2 3
public

 
LocationModel

 $
Location

% -
{

. /
get

0 3
;

3 4
set

5 8
;

8 9
}

: ;
} 	
} É
©/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Models/Users/PasswordEmailModel.cs
	namespace 	
glovo_webapi
 
. 
Models 
. 
Users #
{ 
public 

class 
PasswordEmailModel #
{ 
public 
string 
Email 
{ 
get !
;! "
set# &
;& '
}( )
public 
PasswordEmailModel !
(! "
)" #
{$ %
}% &
public		 
PasswordEmailModel		 !
(		! "
string		" (
email		) .
)		. /
{

 	
Email 
= 
email 
; 
} 	
} 
} ·
©/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Models/Users/PasswordResetModel.cs
	namespace 	
glovo_webapi
 
. 
Models 
. 
Users #
{ 
public 

class 
PasswordResetModel #
{ 
public 
string 
Email 
{ 
get !
;! "
set# &
;& '
}( )
public 
string 
RecoveryToken #
{$ %
get& )
;) *
set+ .
;. /
}0 1
public		 
string		 
NewPassword		 !
{		" #
get		$ '
;		' (
set		) ,
;		, -
}		. /
public 
PasswordResetModel !
(! "
)" #
{$ %
}% &
public 
PasswordResetModel !
(! "
string" (
email) .
,. /
string0 6
recoveryToken7 D
,D E
stringF L
newPasswordM X
)X Y
{ 	
Email 
= 
email 
; 
RecoveryToken 
= 
recoveryToken )
;) *
NewPassword 
= 
newPassword %
;% &
} 	
} 
} ≤

™/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Models/Users/PasswordUpdateModel.cs
	namespace 	
glovo_webapi
 
. 
Models 
. 
Users #
{ 
public 

class 
PasswordUpdateModel $
{ 
[ 	
Required	 
] 
public 
string 
OldPassword !
{" #
get$ '
;' (
set) ,
;, -
}. /
[		 	
Required			 
]		 
public

 
string

 
NewPassword

 !
{

" #
get

$ '
;

' (
set

) ,
;

, -
}

. /
public 
PasswordUpdateModel "
(" #
)# $
{% &
}& '
public 
PasswordUpdateModel "
(" #
string# )
oldPassword* 5
,5 6
string7 =
newPassword> I
)I J
{ 	
OldPassword 
= 
oldPassword %
;% &
NewPassword 
= 
newPassword %
;% &
} 	
} 
} ñ

¨/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Models/Users/ReceiveLoginUserModel.cs
	namespace 	
glovo_webapi
 
. 
Models 
. 
Users #
{ 
public 

class !
ReceiveLoginUserModel &
{ 
[		 	
Required			 
]		 
public

 
string

 
Email

 
{

 
get

 !
;

! "
set

# &
;

& '
}

( )
[ 	
Required	 
] 
public 
string 
Password 
{  
get! $
;$ %
set& )
;) *
}+ ,
public !
ReceiveLoginUserModel $
($ %
)% &
{' (
}( )
public !
ReceiveLoginUserModel $
($ %
string% +
email, 1
,1 2
string3 9
password: B
)B C
{ 	
Email 
= 
email 
; 
Password 
= 
password 
;  
} 	
} 
} …
®/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Models/Users/RegisterUserModel.cs
	namespace 	
glovo_webapi
 
. 
Models 
. 
Users #
{ 
public 

class 
RegisterUserModel "
{ 
[		 	
Required			 
]		 
public

 
string

 
Name

 
{

 
get

  
;

  !
set

" %
;

% &
}

' (
[ 	
Required	 
] 
public 
string 
Email 
{ 
get !
;! "
set# &
;& '
}( )
[ 	
Required	 
] 
public 
string 
Password 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 
RegisterUserModel  
(  !
)! "
{# $
}$ %
public 
RegisterUserModel  
(  !
string! '
name( ,
,, -
string. 4
email5 :
,: ;
string< B
passwordC K
)K L
{ 	
Name 
= 
name 
; 
Email 
= 
email 
; 
Password 
= 
password 
;  
} 	
} 
} ¸
©/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Models/Users/SendLoginUserModel.cs
	namespace 	
glovo_webapi
 
. 
Models 
. 
Users #
{ 
public 

class 
SendLoginUserModel #
{ 
public 
int 
Id 
{ 
get 
; 
set  
;  !
}" #
public 
string 
Name 
{ 
get  
;  !
set" %
;% &
}' (
public 
string 
Email 
{ 
get !
;! "
set# &
;& '
}( )
public 
string 
Token 
{ 
get !
;! "
set# &
;& '
}( )
}		 
}

 Ü	
¶/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Models/Users/UpdateUserModel.cs
	namespace 	
glovo_webapi
 
. 
Models 
. 
Users #
{ 
public 

class 
UpdateUserModel  
{ 
public 
string 
Name 
{ 
get  
;  !
set" %
;% &
}' (
public 
string 
Email 
{ 
get !
;! "
set# &
;& '
}( )
public

 
UpdateUserModel

 
(

 
)

  
{

! "
}

" #
public 
UpdateUserModel 
( 
string %
name& *
,* +
string, 2
email3 8
)8 9
{ 	
Name 
= 
name 
; 
Email 
= 
email 
; 
} 	
} 
} Î

†/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Models/Users/UserModel.cs
	namespace 	
glovo_webapi
 
. 
Models 
. 
Users #
{ 
public 

class 
	UserModel 
{ 
public 
int 
Id 
{ 
get 
; 
set  
;  !
}" #
public 
string 
Email 
{ 
get !
;! "
set# &
;& '
}( )
public		 
string		 
Name		 
{		 
get		  
;		  !
set		" %
;		% &
}		' (
public 
	UserModel 
( 
int 
id 
,  
string! '
email( -
,- .
string/ 5
name6 :
): ;
{ 	
this 
. 
Id 
= 
id 
; 
this 
. 
Email 
= 
email 
; 
this 
. 
Name 
= 
name 
; 
} 	
} 
} Õ
£/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Profiles/LocationsProfile.cs
	namespace 	
glovo_webapi
 
. 
Profiles 
{ 
public 

class 
LocationsProfile !
:" #
Profile$ +
{ 
public		 
LocationsProfile		 
(		  
)		  !
{

 	
	CreateMap 
< 
LocationModel #
,# $
Location% -
>- .
(. /
)/ 0
;0 1
	CreateMap 
< 
Location 
, 
LocationModel  -
>- .
(. /
)/ 0
;0 1
} 	
} 
} Ï
®/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Profiles/OrdersProductsProfile.cs
	namespace 	
glovo_webapi
 
. 
Profiles 
{ 
public 

class !
OrdersProductsProfile &
:' (
Profile) 0
{ 
public		 !
OrdersProductsProfile		 $
(		$ %
)		% &
{

 	
	CreateMap 
< 
OrderProduct "
," #
OrderProductModel$ 5
>5 6
(6 7
)7 8
;8 9
	CreateMap 
< 
OrderProductModel '
,' (
OrderProduct) 5
>5 6
(6 7
)7 8
;8 9
} 	
} 
} ˜
†/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Profiles/OrdersProfile.cs
	namespace 	
glovo_webapi
 
. 
Profiles 
{ 
public 

class 
OrdersProfile 
:  
Profile! (
{		 
public

 
OrdersProfile

 
(

 
)

 
{ 	
	CreateMap 
< 
Order 
, 
GetOrderModel *
>* +
(+ ,
), -
. 
	ForMember 
( 
getOrderModel (
=>) +
getOrderModel, 9
.9 :
Products: B
,B C
opts 
=> 
opts 
. 
MapFrom $
($ %
order% *
=>+ -
order. 3
.3 4
OrdersProducts4 B
)B C
)C D
;D E
	CreateMap 
< 
PostOrderModel $
,$ %
Order& +
>+ ,
(, -
)- .
. 
	ForMember 
( 
order  
=>! #
order$ )
.) *
OrdersProducts* 8
,8 9
opts 
=> 
opts 
. 
MapFrom $
($ %
postOrderModel% 3
=>4 6
postOrderModel7 E
.E F
ProductsF N
)N O
)O P
. 
	ForMember 
( 
order  
=>! #
order$ )
.) *
BuyDateTime* 5
,5 6
opts 
=> 
opts 
. 
MapFrom $
($ %
postOrderModel% 3
=>4 6
DateTime7 ?
.? @
UtcNow@ F
)F G
)G H
;H I
} 	
} 
} ¶
¢/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Profiles/ProductsProfile.cs
	namespace 	
glovo_webapi
 
. 
Profiles 
{ 
public 

class 
ProductsProfile  
:! "
Profile# *
{ 
public		 
ProductsProfile		 
(		 
)		  
{

 	
	CreateMap 
< 
Product 
, 
ProductModel +
>+ ,
(, -
)- .
;. /
} 	
} 
} Ï%
•/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Profiles/RestaurantsProfile.cs
	namespace 	
glovo_webapi
 
. 
Profiles 
{ 
public 

class "
CustomDistanceResolver '
:( )
IValueResolver* 8
<8 9

Restaurant9 C
,C D#
DistanceRestaurantModelE \
,\ ]
double^ d
?d e
>e f
{		 
public

 
double

 
?

 
Resolve

 
(

 

Restaurant

 )

restaurant

* 4
,

4 5#
DistanceRestaurantModel

6 M#
distanceRestaurantModel

N e
,

e f
double

g m
?

m n
member

o u
,

u v
ResolutionContext	

w à
context


â ê
)


ê ë
{ 	
if 
( 
context 
. 
Items 
[ 
$str ,
], -
==. 0
null1 5
)5 6
{ 
return 
null 
; 
} 
return 

restaurant 
. 
Location &
.& '

DistanceTo' 1
(1 2
(2 3
Location3 ;
); <
context= D
.D E
ItemsE J
[J K
$strK Y
]Y Z
)Z [
;[ \
} 	
} 
public 

class %
CustomDeliveryFeeResolver *
:+ ,
IValueResolver- ;
<; <

Restaurant< F
,F G#
DistanceRestaurantModelH _
,_ `
doublea g
?g h
>h i
{ 
public 
double 
? 
Resolve 
( 

Restaurant )

restaurant* 4
,4 5#
DistanceRestaurantModel6 M#
distanceRestaurantModelN e
,e f
doubleg m
?m n
membero u
,u v
ResolutionContext	w à
context
â ê
)
ê ë
{ 	
if 
( 
context 
. 
Items 
[ 
$str ,
], -
==. 0
null1 5
||6 8
context9 @
.@ A
ItemsA F
[F G
$strG ^
]^ _
==` b
nullc g
)g h
{ 
return 
null 
; 
} 
double 
distance 
= 

restaurant (
.( )
Location) 1
.1 2

DistanceTo2 <
(< =
(= >
Location> F
)F G
contextH O
.O P
ItemsP U
[U V
$strV d
]d e
)e f
;f g
return 
( 
( 
Func 
< 
double  
,  !
double" (
>( )
)) *
context+ 2
.2 3
Items3 8
[8 9
$str9 P
]P Q
)Q R
.R S
InvokeS Y
(Y Z
distanceZ b
)b c
;c d
} 	
}   
public"" 

class"" 
RestaurantsProfile"" #
:""$ %
Profile""& -
{## 
public$$ 
RestaurantsProfile$$ !
($$! "
)$$" #
{%% 	
	CreateMap&& 
<&& 

Restaurant&&  
,&&  !#
LocationRestaurantModel&&" 9
>&&9 :
(&&: ;
)&&; <
;&&< =
	CreateMap(( 
<(( 

Restaurant((  
,((  !#
DistanceRestaurantModel((" 9
>((9 :
(((: ;
)((; <
.)) 
	ForMember)) 
()) 
viewRestaurantModel** '
=>**( *
viewRestaurantModel**+ >
.**> ?
Distance**? G
,**G H
opts++ 
=>++ 
opts++  
.++  !
MapFrom++! (
<++( )"
CustomDistanceResolver++) ?
>++? @
(++@ A
)++A B
)++B C
.,, 
	ForMember,, 
(,, 
viewRestaurantModel-- '
=>--( *
viewRestaurantModel--+ >
.--> ?
DeliveryFee--? J
,--J K
opts.. 
=>.. 
opts..  
...  !
MapFrom..! (
<..( )%
CustomDeliveryFeeResolver..) B
>..B C
(..C D
)..D E
)..E F
;// 
}00 	
}11 
}22 ¸
ü/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Profiles/UsersProfile.cs
	namespace 	
glovo_webapi
 
. 
Profiles 
{ 
public 

class 
UsersProfile 
: 
Profile  '
{ 
public		 
UsersProfile		 
(		 
)		 
{

 	
	CreateMap 
< 
User 
, 
	UserModel %
>% &
(& '
)' (
;( )
	CreateMap 
< 
User 
, 
SendLoginUserModel .
>. /
(/ 0
)0 1
;1 2
	CreateMap 
< 
RegisterUserModel '
,' (
User) -
>- .
(. /
)/ 0
;0 1
	CreateMap 
< 
UpdateUserModel %
,% &
User' +
>+ ,
(, -
)- .
;. /
} 	
} 
} Ï

ë/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Program.cs
	namespace

 	
glovo_webapi


 
{ 
public 

class 
Program 
{ 
public 
static 
void 
Main 
(  
string  &
[& '
]' (
args) -
)- .
{ 	
CreateHostBuilder 
( 
args "
)" #
.# $
Build$ )
() *
)* +
.+ ,
Run, /
(/ 0
)0 1
;1 2
} 	
public 
static 
IHostBuilder "
CreateHostBuilder# 4
(4 5
string5 ;
[; <
]< =
args> B
)B C
=>D F
Host 
.  
CreateDefaultBuilder %
(% &
args& *
)* +
.   $
ConfigureWebHostDefaults   )
(  ) *

webBuilder  * 4
=>  5 7
{  8 9

webBuilder  : D
.  D E

UseStartup  E O
<  O P
Startup  P W
>  W X
(  X Y
)  Y Z
;  Z [
}  \ ]
)  ] ^
;  ^ _
}!! 
}"" ⁄
ù/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Services/Exceptions.cs
	namespace 	
glovo_webapi
 
. 
Services 
{ 
internal 
static 
class 
UserExceptionCodes ,
{ 
public 
const 
int 
InvalidCredentials +
=, -
$num. /
;/ 0
public 
const 
int 
UserNotFound %
=& '
$num( )
;) *
public 
const 
int 
BadPassword $
=% &
$num' (
;( )
public 
const 
int 
EmailAlreadyExists +
=, -
$num. /
;/ 0
public		 
const		 
int		 
NoLoggedUser		 %
=		& '
$num		( )
;		) *
}

 
internal 
static 
class 
OrderExceptionCodes -
{ 
public 
const 
int 
RestaurantNotFound +
=, -
$num. /
;/ 0
public 
const 
int 
UserNotFound %
=& '
$num( )
;) *
public 
const 
int 
OrderNotFound &
=' (
$num) *
;* +
public 
const 
int 
ProductNotFound (
=) *
$num+ ,
;, -
public 
const 
int 
BadOrderProduct (
=) *
$num+ ,
;, -
public 
const 
int +
ProductNotBelongingToRestaurant 8
=9 :
$num; <
;< =
} 
internal 
static 
class $
RestaurantExceptionCodes 2
{ 
public 
const 
int 
RestaurantNotFound +
=, -
$num. /
;/ 0
} 
internal 
static 
class !
ProductExceptionCodes /
{ 
public 
const 
int 
RestaurantNotFound +
=, -
$num. /
;/ 0
public 
const 
int 
ProductNotFound (
=) *
$num+ ,
;, -
} 
}   ¨	
®/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Services/Orders/IOrdersService.cs
	namespace 	
glovo_webapi
 
. 
Services 
.  
Orders  &
{ 
public 

	interface 
IOrdersService #
{ 
IEnumerable 
< 
Order 
> 
GetAllOrders '
(' (
)( )
;) *
Order		 
GetOrderById		 
(		 
int		 
orderId		 &
)		& '
;		' (
Order

 
AddOrder

 
(

 
Order

 
order

 "
)

" #
;

# $
IEnumerable 
< 
Order 
> 
GetAllOrdersOfUser -
(- .
int. 1
userId2 8
)8 9
;9 :
IEnumerable 
< 
Order 
> $
GetAllOrdersOfRestaurant 3
(3 4
int4 7
restId8 >
)> ?
;? @
} 
} ´L
Æ/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Services/Orders/RestApiOrdersService.cs
	namespace		 	
glovo_webapi		
 
.		 
Services		 
.		  
Orders		  &
{

 
public 

class  
RestApiOrdersService %
:& '
IOrdersService( 6
{ 
private 
readonly 
GlovoDbContext '
_context( 0
;0 1
private 
readonly  
IHttpContextAccessor - 
_httpContextAccessor. B
;B C
public  
RestApiOrdersService #
(# $
GlovoDbContext$ 2
context3 :
,: ; 
IHttpContextAccessor< P
httpContextAccessorQ d
)d e
{ 	
_context 
= 
context 
;  
_httpContextAccessor  
=! "
httpContextAccessor# 6
;6 7
} 	
public 
IEnumerable 
< 
Order  
>  !
GetAllOrders" .
(. /
)/ 0
{ 	
return 
_context 
. 
Orders "
. 
Include 
( 
order 
=> !
order" '
.' (

Restaurant( 2
)2 3
. 
Include 
( 
order 
=> !
order" '
.' (
User( ,
), -
. 
Include 
( 
order 
=> !
order" '
.' (
OrdersProducts( 6
)6 7
. 
ToList 
( 
) 
; 
} 	
public 
Order 
GetOrderById !
(! "
int" %
orderId& -
)- .
{   	
Order!! 

foundOrder!! 
=!! 
_context!! '
.!!' (
Orders!!( .
."" 
Include"" 
("" 
order"" 
=>"" !
order""" '
.""' (

Restaurant""( 2
)""2 3
.## 
Include## 
(## 
order## 
=>## !
order##" '
.##' (
User##( ,
)##, -
.$$ 
Include$$ 
($$ 
order$$ 
=>$$ !
order$$" '
.$$' (
OrdersProducts$$( 6
)$$6 7
.%% 
FirstOrDefault%% 
(%%  
o%%  !
=>%%" $
o%%% &
.%%& '
Id%%' )
==%%* ,
orderId%%- 4
)%%4 5
;%%5 6
if&& 
(&& 

foundOrder&& 
==&& 
null&& "
)&&" #
throw'' 
new'' 
RequestException'' *
(''* +
OrderExceptionCodes''+ >
.''> ?
OrderNotFound''? L
)''L M
;''M N
return)) 

foundOrder)) 
;)) 
}** 	
public,, 
Order,, 
AddOrder,, 
(,, 
Order,, #
order,,$ )
),,) *
{-- 	

Restaurant// 
orderRestaurant// &
=//' (
_context//) 1
.//1 2
Restaurants//2 =
.//= >
FirstOrDefault//> L
(//L M
r//M N
=>//O Q
r//R S
.//S T
Id//T V
==//W Y
order//Z _
.//_ `
RestaurantId//` l
)//l m
;//m n
if00 
(00 
orderRestaurant00 
==00  "
null00# '
)00' (
throw11 
new11 
RequestException11 *
(11* +
OrderExceptionCodes11+ >
.11> ?
RestaurantNotFound11? Q
)11Q R
;11R S
foreach44 
(44 
OrderProduct44 !
orderProduct44" .
in44/ 1
order442 7
.447 8
OrdersProducts448 F
)44F G
{44H I
if55 
(55 
orderProduct55 
==55  "
null55# '
)55' (
throw66 
new66 
RequestException66 .
(66. /
OrderExceptionCodes66/ B
.66B C
BadOrderProduct66C R
)66R S
;66S T
Product77 
product77 
=77  !
_context77" *
.77* +
Products77+ 3
.773 4
FirstOrDefault774 B
(77B C
p77C D
=>77E G
p77H I
.77I J
Id77J L
==77M O
orderProduct77P \
.77\ ]
	ProductId77] f
)77f g
;77g h
if88 
(88 
product88 
==88 
null88 #
)88# $
throw99 
new99 
RequestException99 .
(99. /
OrderExceptionCodes99/ B
.99B C
ProductNotFound99C R
)99R S
;99S T
if:: 
(:: 
product:: 
.:: 
RestaurantId:: (
!=::) +
order::, 1
.::1 2
RestaurantId::2 >
)::> ?
throw;; 
new;; 
RequestException;; .
(;;. /
OrderExceptionCodes;;/ B
.;;B C+
ProductNotBelongingToRestaurant;;C b
);;b c
;;;c d
}<< 
User?? 

loggedUser?? 
=?? 
(?? 
User?? #
)??# $ 
_httpContextAccessor??% 9
.??9 :
HttpContext??: E
.??E F
Items??F K
[??K L
$str??L R
]??R S
;??S T
order@@ 
.@@ 
UserId@@ 
=@@ 

loggedUser@@ %
.@@% &
Id@@& (
;@@( )
orderCC 
.CC 
IdCC 
=CC 
$numCC 
;CC 
_contextDD 
.DD 
OrdersDD 
.DD 
AddDD 
(DD  
orderDD  %
)DD% &
;DD& '
_contextEE 
.EE 
SaveChangesEE  
(EE  !
)EE! "
;EE" #
returnGG 
orderGG 
;GG 
}HH 	
publicJJ 
IEnumerableJJ 
<JJ 
OrderJJ  
>JJ  !
GetAllOrdersOfUserJJ" 4
(JJ4 5
intJJ5 8
userIdJJ9 ?
)JJ? @
{KK 	
UserLL 
uLL 
=LL 
_contextLL 
.LL 
UsersLL #
.LL# $
SingleOrDefaultLL$ 3
(LL3 4
userLL4 8
=>LL9 ;
userLL< @
.LL@ A
IdLLA C
==LLD F
userIdLLG M
)LLM N
;LLN O
ifMM 
(MM 
uMM 
==MM 
nullMM 
)MM 
throwNN 
newNN 
RequestExceptionNN *
(NN* +
OrderExceptionCodesNN+ >
.NN> ?
UserNotFoundNN? K
)NNK L
;NNL M
returnPP 
_contextPP 
.PP 
OrdersPP "
.QQ 
IncludeQQ 
(QQ 
orderQQ 
=>QQ !
orderQQ" '
.QQ' (

RestaurantQQ( 2
)QQ2 3
.RR 
IncludeRR 
(RR 
orderRR 
=>RR !
orderRR" '
.RR' (
UserRR( ,
)RR, -
.SS 
IncludeSS 
(SS 
orderSS 
=>SS !
orderSS" '
.SS' (
OrdersProductsSS( 6
)SS6 7
.TT 
WhereTT 
(TT 
oTT 
=>TT 
oTT 
.TT 
UserTT "
.TT" #
IdTT# %
==TT& (
userIdTT) /
)TT/ 0
.TT0 1
ToListTT1 7
(TT7 8
)TT8 9
;TT9 :
}UU 	
publicWW 
IEnumerableWW 
<WW 
OrderWW  
>WW  !$
GetAllOrdersOfRestaurantWW" :
(WW: ;
intWW; >
restIdWW? E
)WWE F
{XX 	

RestaurantYY 
rYY 
=YY 
_contextYY #
.YY# $
RestaurantsYY$ /
.YY/ 0
SingleOrDefaultYY0 ?
(YY? @
pYY@ A
=>YYB D
pYYE F
.YYF G
IdYYG I
==YYJ L
restIdYYM S
)YYS T
;YYT U
ifZZ 
(ZZ 
rZZ 
==ZZ 
nullZZ 
)ZZ 
throw[[ 
new[[ 
RequestException[[ *
([[* +
OrderExceptionCodes[[+ >
.[[> ?
RestaurantNotFound[[? Q
)[[Q R
;[[R S
return]] 
_context]] 
.]] 
Orders]] "
.^^ 
Include^^ 
(^^ 
order^^ 
=>^^ !
order^^" '
.^^' (

Restaurant^^( 2
)^^2 3
.__ 
Include__ 
(__ 
order__ 
=>__ !
order__" '
.__' (
User__( ,
)__, -
.`` 
Include`` 
(`` 
order`` 
=>`` !
order``" '
.``' (
OrdersProducts``( 6
)``6 7
.aa 
Whereaa 
(aa 
oaa 
=>aa 
oaa 
.aa 

Restaurantaa (
.aa( )
Idaa) +
==aa, .
restIdaa/ 5
)aa5 6
.aa6 7
ToListaa7 =
(aa= >
)aa> ?
;aa? @
}bb 	
}cc 
}dd ÷

¨/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Services/Products/IProductsService.cs
	namespace 	
glovo_webapi
 
. 
Services 
.  
Products  (
{ 
public 

	interface 
IProductsService %
{ 
IEnumerable		 
<		 
Product		 
>		 
GetAllProducts		 +
(		+ ,
)		, -
;		- .
IEnumerable

 
<

 
Product

 
>

 !
GetProductsByCategory

 2
(

2 3
ProductCategory

3 B
c

C D
)

D E
;

E F
Product 
GetProductById 
( 
int "
id# %
)% &
;& '
IEnumerable 
< 
Product 
> &
GetAllProductsOfRestaurant 7
(7 8
int8 ;
idRest< B
)B C
;C D
IEnumerable 
< 
Product 
> 0
$GetAllProductsOfRestaurantByCategory A
(A B
intB E
idRestF L
,L M
ProductCategoryN ]
c^ _
)_ `
;` a
} 
} ”,
≤/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Services/Products/RestApiProductsService.cs
	namespace 	
glovo_webapi 
. 
Services  
.  !
Products! )
{ 
public		 

class		 "
RestApiProductsService		 '
:		( )
IProductsService		* :
{

 
private 
readonly 
GlovoDbContext '
_context( 0
;0 1
public "
RestApiProductsService %
(% &
GlovoDbContext& 4
context5 <
)< =
{ 	
_context 
= 
context 
; 
} 	
public 
IEnumerable 
< 
Product "
>" #
GetAllProducts$ 2
(2 3
)3 4
{ 	
return 
_context 
. 
Products $
.$ %
ToList% +
(+ ,
), -
;- .
} 	
public 
IEnumerable 
< 
Product "
>" #!
GetProductsByCategory$ 9
(9 :
ProductCategory: I
cJ K
)K L
{ 	
if 
( 
c 
== 
ProductCategory $
.$ %
Uncategorized% 2
)2 3
{ 
return 
_context 
.  
Products  (
.( )
ToList) /
(/ 0
)0 1
;1 2
} 
return 
_context 
. 
Products $
.$ %
Where% *
(* +
p+ ,
=>- /
p0 1
.1 2
Category2 :
==; =
c> ?
)? @
;@ A
} 	
public   
Product   
GetProductById   %
(  % &
int  & )
id  * ,
)  , -
{!! 	
Product"" 
foundProduct""  
=""! "
_context""# +
.""+ ,
Products"", 4
.""4 5
FirstOrDefault""5 C
(""C D
p""D E
=>""F H
p""I J
.""J K
Id""K M
==""N P
id""Q S
)""S T
;""T U
if## 
(## 
foundProduct## 
==## 
null##  $
)##$ %
{$$ 
throw%% 
new%% 
RequestException%% *
(%%* +!
ProductExceptionCodes%%+ @
.%%@ A
ProductNotFound%%A P
)%%P Q
;%%Q R
}&& 
return(( 
foundProduct(( 
;((  
})) 	
public++ 
IEnumerable++ 
<++ 
Product++ "
>++" #&
GetAllProductsOfRestaurant++$ >
(++> ?
int++? B
idRest++C I
)++I J
{,, 	

Restaurant-- 
r-- 
=-- 
_context-- #
.--# $
Restaurants--$ /
.--/ 0
SingleOrDefault--0 ?
(--? @
p--@ A
=>--B D
p--E F
.--F G
Id--G I
==--J L
idRest--M S
)--S T
;--T U
if.. 
(.. 
r.. 
==.. 
null.. 
).. 
throw// 
new// 
RequestException// *
(//* +!
ProductExceptionCodes//+ @
.//@ A
RestaurantNotFound//A S
)//S T
;//T U
return00 
_context00 
.00 
Products00 $
.00$ %
Where00% *
(00* +
p00+ ,
=>00- /
p000 1
.001 2
RestaurantId002 >
==00? A
idRest00B H
)00H I
;00I J
}11 	
public33 
IEnumerable33 
<33 
Product33 "
>33" #0
$GetAllProductsOfRestaurantByCategory33$ H
(33H I
int33I L
idRest33M S
,33S T
ProductCategory33U d
c33e f
)33f g
{44 	

Restaurant55 
r55 
=55 
_context55 #
.55# $
Restaurants55$ /
.55/ 0
SingleOrDefault550 ?
(55? @
p55@ A
=>55B D
p55E F
.55F G
Id55G I
==55J L
idRest55M S
)55S T
;55T U
if66 
(66 
r66 
==66 
null66 
)66 
throw77 
new77 
RequestException77 *
(77* +!
ProductExceptionCodes77+ @
.77@ A
RestaurantNotFound77A S
)77S T
;77T U
if88 
(88 
c88 
==88 
ProductCategory88 $
.88$ %
Uncategorized88% 2
)882 3
return99 
_context99 
.99  
Products99  (
.99( )
Where99) .
(99. /
p99/ 0
=>991 3
p994 5
.995 6
RestaurantId996 B
==99C E
idRest99F L
)99L M
;99M N
return:: 
_context:: 
.:: 
Products:: $
.::$ %
Where::% *
(::* +
p::+ ,
=>::- /
p::0 1
.::1 2
RestaurantId::2 >
==::? A
idRest::B H
&&::I K
p::L M
.::M N
Category::N V
==::W Y
c::Z [
)::[ \
;::\ ]
};; 	
}<< 
}== ∂
£/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Services/RequestException.cs
	namespace 	
glovo_webapi
 
. 
Services 
{ 
public 

class 
RequestException !
:" #
	Exception$ -
{ 
public 
int 
Code 
{ 
get 
; 
}  
public		 
RequestException		 
(		  
int		  #
code		$ (
)		( )
:		* +
base		, 0
(		0 1
$str		1 3
)		3 4
{

 	
Code 
= 
code 
; 
} 	
} 
} ’
≤/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Services/Restaurants/IRestaurantsService.cs
	namespace 	
glovo_webapi
 
. 
Services 
.  
Restaurants  +
{ 
public 

	interface 
IRestaurantsService (
{ 
IEnumerable 
< 

Restaurant 
> 
GetAllRestaurants  1
(1 2
)2 3
;3 4

Restaurant		 
GetRestaurantById		 $
(		$ %
int		% (
id		) +
)		+ ,
;		, -
}

 
} ä
∏/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Services/Restaurants/RestApiRestaurantsService.cs
	namespace 	
glovo_webapi 
. 
Services  
.  !
Restaurants! ,
{ 
public 

class %
RestApiRestaurantsService *
:+ ,
IRestaurantsService- @
{		 
private

 
readonly

 
GlovoDbContext

 '
_context

( 0
;

0 1
public %
RestApiRestaurantsService (
(( )
GlovoDbContext) 7
context8 ?
)? @
{ 	
_context 
= 
context 
; 
} 	
public 
IEnumerable 
< 

Restaurant %
>% &
GetAllRestaurants' 8
(8 9
)9 :
{ 	
return 
_context 
. 
Restaurants '
.' (
ToList( .
(. /
)/ 0
;0 1
} 	
public 

Restaurant 
GetRestaurantById +
(+ ,
int, /
id0 2
)2 3
{ 	

Restaurant 
foundRestaurant &
=' (
_context) 1
.1 2
Restaurants2 =
.= >
FirstOrDefault> L
(L M
rM N
=>O Q
rR S
.S T
IdT V
==W Y
idZ \
)\ ]
;] ^
if 
( 
foundRestaurant 
==  "
null# '
)' (
throw 
new 
RequestException *
(* +$
RestaurantExceptionCodes+ C
.C D
RestaurantNotFoundD V
)V W
;W X
return 
foundRestaurant "
;" #
} 	
} 
} ¯
¨/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Services/UserService/IUsersService.cs
	namespace 	
glovo_webapi
 
. 
Services 
.  
UserService  +
{ 
public 

	interface 
IUsersService "
{ 
User 
Authenticate 
( 
string  
email! &
,& '
string( .
password/ 7
)7 8
;8 9
IEnumerable		 
<		 
User		 
>		 
GetAll		  
(		  !
)		! "
;		" #
User

 
GetById

 
(

 
int

 
id

 
)

 
;

 
User 

GetByEmail 
( 
string 
email $
)$ %
;% &
User 
Create 
( 
User 
user 
, 
string %
password& .
). /
;/ 0
void 

SetProfile 
( 
User 
user !
,! "
string# )
name* .
,. /
string0 6
email7 <
)< =
;= >
void 
SetNewPassword 
( 
User  
user! %
,% &
string' -
newPassword. 9
,9 :
string; A
oldPasswordB M
=M N
nullN R
)R S
;S T
void 
Update 
( 
User 
user 
) 
; 
void 
Delete 
( 
int 
id 
) 
; 
} 
} ©^
≤/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Services/UserService/RestApiUsersService.cs
	namespace		 	
glovo_webapi		
 
.		 
Services		 
.		  
UserService		  +
{

 
public 

class 
RestApiUsersService $
:% &
IUsersService' 4
{ 
private 
readonly 
GlovoDbContext '
_context( 0
;0 1
private 
readonly  
IHttpContextAccessor - 
_httpContextAccessor. B
;B C
public 
RestApiUsersService "
(" #
GlovoDbContext# 1
context2 9
,9 : 
IHttpContextAccessor; O
httpContextAccessorP c
)c d
{ 	
_context 
= 
context 
;  
_httpContextAccessor  
=! "
httpContextAccessor# 6
;6 7
} 	
public 
User 
Authenticate  
(  !
string! '
email( -
,- .
string/ 5
password6 >
)> ?
{ 	
if 
( 
string 
. 
IsNullOrEmpty $
($ %
email% *
)* +
||, .
string/ 5
.5 6
IsNullOrEmpty6 C
(C D
passwordD L
)L M
)M N
throw 
new 
RequestException *
(* +
UserExceptionCodes+ =
.= >
InvalidCredentials> P
)P Q
;Q R
var 
user 
= 
_context 
.  
Users  %
.% &
SingleOrDefault& 5
(5 6
x6 7
=>8 :
x; <
.< =
Email= B
==C E
emailF K
)K L
;L M
if 
( 
user 
== 
null 
) 
throw 
new 
RequestException *
(* +
UserExceptionCodes+ =
.= >
InvalidCredentials> P
)P Q
;Q R
if"" 
("" 
!"" 
PasswordVerifier"" !
.""! "
VerifyPasswordHash""" 4
(""4 5
password""5 =
,""= >
user""? C
.""C D
PasswordHash""D P
,""P Q
user""R V
.""V W
PasswordSalt""W c
)""c d
)""d e
throw## 
new## 
RequestException## *
(##* +
UserExceptionCodes##+ =
.##= >
InvalidCredentials##> P
)##P Q
;##Q R
return&& 
user&& 
;&& 
}'' 	
public)) 
IEnumerable)) 
<)) 
User)) 
>))  
GetAll))! '
())' (
)))( )
{** 	
return++ 
_context++ 
.++ 
Users++ !
;++! "
},, 	
public.. 
User.. 
GetById.. 
(.. 
int.. 
id..  "
).." #
{// 	
User00 
u00 
=00 
_context00 
.00 
Users00 #
.00# $
Find00$ (
(00( )
id00) +
)00+ ,
;00, -
if11 
(11 
u11 
==11 
null11 
)11 
throw22 
new22 
RequestException22 *
(22* +
UserExceptionCodes22+ =
.22= >
UserNotFound22> J
)22J K
;22K L
return44 
u44 
;44 
}55 	
public77 
User77 

GetByEmail77 
(77 
string77 %
email77& +
)77+ ,
{88 	
User99 
u99 
=99 
_context99 
.99 
Users99 #
.99# $
FirstOrDefault99$ 2
(992 3
user993 7
=>998 :
user99; ?
.99? @
Email99@ E
==99F H
email99I N
)99N O
;99O P
if:: 
(:: 
u:: 
==:: 
null:: 
):: 
throw;; 
new;; 
RequestException;; *
(;;* +
UserExceptionCodes;;+ =
.;;= >
UserNotFound;;> J
);;J K
;;;K L
return== 
u== 
;== 
}>> 	
public@@ 
User@@ 
Create@@ 
(@@ 
User@@ 
user@@  $
,@@$ %
string@@& ,
password@@- 5
)@@5 6
{AA 	
ifCC 
(CC 
stringCC 
.CC 
IsNullOrWhiteSpaceCC )
(CC) *
passwordCC* 2
)CC2 3
)CC3 4
throwDD 
newDD 
RequestExceptionDD *
(DD* +
UserExceptionCodesDD+ =
.DD= >
BadPasswordDD> I
)DDI J
;DDJ K
ifFF 
(FF 
_contextFF 
.FF 
UsersFF 
.FF 
AnyFF "
(FF" #
xFF# $
=>FF% '
xFF( )
.FF) *
EmailFF* /
==FF0 2
userFF3 7
.FF7 8
EmailFF8 =
)FF= >
)FF> ?
throwGG 
newGG 
RequestExceptionGG *
(GG* +
UserExceptionCodesGG+ =
.GG= >
EmailAlreadyExistsGG> P
)GGP Q
;GGQ R
byteII 
[II 
]II 
passwordHashII 
,II  
passwordSaltII! -
;II- .
PasswordVerifierJJ 
.JJ 
CreatePasswordHashJJ /
(JJ/ 0
passwordJJ0 8
,JJ8 9
outJJ: =
passwordHashJJ> J
,JJJ K
outJJL O
passwordSaltJJP \
)JJ\ ]
;JJ] ^
userLL 
.LL 
PasswordHashLL 
=LL 
passwordHashLL  ,
;LL, -
userMM 
.MM 
PasswordSaltMM 
=MM 
passwordSaltMM  ,
;MM, -
userOO 
.OO 
LocationOO 
=OO 
nullOO  
;OO  !
_contextQQ 
.QQ 
UsersQQ 
.QQ 
AddQQ 
(QQ 
userQQ #
)QQ# $
;QQ$ %
_contextRR 
.RR 
SaveChangesRR  
(RR  !
)RR! "
;RR" #
returnTT 
userTT 
;TT 
}UU 	
publicWW 
voidWW 

SetProfileWW 
(WW 
UserWW #
userWW$ (
,WW( )
stringWW* 0
nameWW1 5
,WW5 6
stringWW7 =
emailWW> C
)WWC D
{XX 	
ifYY 
(YY 
!YY 
stringYY 
.YY 
IsNullOrWhiteSpaceYY *
(YY* +
emailYY+ 0
)YY0 1
&&YY2 4
emailYY5 :
!=YY; =
userYY> B
.YYB C
EmailYYC H
)YYH I
{ZZ 
if\\ 
(\\ 
_context\\ 
.\\ 
Users\\ "
.\\" #
Any\\# &
(\\& '
x\\' (
=>\\) +
x\\, -
.\\- .
Email\\. 3
==\\4 6
email\\7 <
)\\< =
)\\= >
throw]] 
new]] 
RequestException]] .
(]]. /
UserExceptionCodes]]/ A
.]]A B
EmailAlreadyExists]]B T
)]]T U
;]]U V
user__ 
.__ 
Email__ 
=__ 
email__ "
;__" #
}`` 
ifbb 
(bb 
!bb 
stringbb 
.bb 
IsNullOrEmptybb %
(bb% &
namebb& *
)bb* +
)bb+ ,
usercc 
.cc 
Namecc 
=cc 
namecc  
;cc  !
_contextee 
.ee 
Usersee 
.ee 
Updateee !
(ee! "
useree" &
)ee& '
;ee' (
_contextff 
.ff 
SaveChangesff  
(ff  !
)ff! "
;ff" #
}gg 	
publicii 
voidii 
SetNewPasswordii "
(ii" #
Userii# '
userii( ,
,ii, -
stringii. 4
newPasswordii5 @
,ii@ A
stringiiB H
oldPasswordiiI T
=iiU V
nulliiW [
)ii[ \
{jj 	
ifkk 
(kk 
oldPasswordkk 
!=kk 
nullkk #
&&kk$ &
!kk' (
PasswordVerifierkk( 8
.kk8 9
VerifyPasswordHashkk9 K
(kkK L
oldPasswordkkL W
,kkW X
userkkY ]
.kk] ^
PasswordHashkk^ j
,kkj k
userkkl p
.kkp q
PasswordSaltkkq }
)kk} ~
)kk~ 
throwll 
newll 
RequestExceptionll *
(ll* +
UserExceptionCodesll+ =
.ll= >
InvalidCredentialsll> P
)llP Q
;llQ R
ifnn 
(nn 
stringnn 
.nn 
IsNullOrWhiteSpacenn )
(nn) *
newPasswordnn* 5
)nn5 6
)nn6 7
throwoo 
newoo 
RequestExceptionoo *
(oo* +
UserExceptionCodesoo+ =
.oo= >
BadPasswordoo> I
)ooI J
;ooJ K
byteqq 
[qq 
]qq 
passwordHashqq 
,qq  
passwordSaltqq! -
;qq- .
PasswordVerifierrr 
.rr 
CreatePasswordHashrr /
(rr/ 0
newPasswordrr0 ;
,rr; <
outrr= @
passwordHashrrA M
,rrM N
outrrO R
passwordSaltrrS _
)rr_ `
;rr` a
userss 
.ss 
PasswordHashss 
=ss 
passwordHashss  ,
;ss, -
usertt 
.tt 
PasswordSalttt 
=tt 
passwordSalttt  ,
;tt, -
_contextuu 
.uu 
Usersuu 
.uu 
Updateuu !
(uu! "
useruu" &
)uu& '
;uu' (
_contextvv 
.vv 
SaveChangesvv  
(vv  !
)vv! "
;vv" #
}ww 	
publicyy 
voidyy 
Updateyy 
(yy 
Useryy 
useryy  $
)yy$ %
{zz 	
_context{{ 
.{{ 
Users{{ 
.{{ 
Update{{ !
({{! "
user{{" &
){{& '
;{{' (
_context|| 
.|| 
SaveChanges||  
(||  !
)||! "
;||" #
}}} 	
public 
void 
Delete 
( 
int 
id !
)! "
{
ÄÄ 	
var
ÅÅ 
user
ÅÅ 
=
ÅÅ 
_context
ÅÅ 
.
ÅÅ  
Users
ÅÅ  %
.
ÅÅ% &
Find
ÅÅ& *
(
ÅÅ* +
id
ÅÅ+ -
)
ÅÅ- .
;
ÅÅ. /
if
ÇÇ 
(
ÇÇ 
user
ÇÇ 
==
ÇÇ 
null
ÇÇ 
)
ÇÇ 
throw
ÉÉ 
new
ÉÉ 
RequestException
ÉÉ *
(
ÉÉ* + 
UserExceptionCodes
ÉÉ+ =
.
ÉÉ= >
UserNotFound
ÉÉ> J
)
ÉÉJ K
;
ÉÉK L
_context
ÖÖ 
.
ÖÖ 
Users
ÖÖ 
.
ÖÖ 
Remove
ÖÖ !
(
ÖÖ! "
user
ÖÖ" &
)
ÖÖ& '
;
ÖÖ' (
_context
ÜÜ 
.
ÜÜ 
SaveChanges
ÜÜ  
(
ÜÜ  !
)
ÜÜ! "
;
ÜÜ" #
}
áá 	
}
àà 
}ââ ›I
ë/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Startup.cs
	namespace 	
glovo_webapi
 
{ 
public 

class 
Startup 
{ 
public 
IConfiguration 
Configuration +
{, -
get. 1
;1 2
}3 4
public 
IWebHostEnvironment "
Env# &
{' (
get) ,
;, -
}. /
readonly 
string 
AllowedOrigins &
=' (
$str) :
;: ;
public 
Startup 
( 
IWebHostEnvironment *
env+ .
,. /
IConfiguration0 >
configuration? L
)L M
{ 	
Env 
= 
env 
; 
var 
builder 
= 
new  
ConfigurationBuilder 2
(2 3
)3 4
. 
SetBasePath 
( 
env  
.  !
ContentRootPath! 0
)0 1
. 
AddJsonFile 
( 
$str /
,/ 0
optional1 9
:9 :
true; ?
,? @
reloadOnChangeA O
:O P
trueQ U
)U V
;V W
Configuration!! 
=!! 
builder!! #
.!!# $
Build!!$ )
(!!) *
)!!* +
;!!+ ,
}"" 	
public%% 
void%% 
ConfigureServices%% %
(%%% &
IServiceCollection%%& 8
services%%9 A
)%%A B
{&& 	
services'' 
.'' 
AddCors'' 
('' 
options'' $
=>''% '
{(( 
options)) 
.)) 
	AddPolicy)) !
())! "
name))" &
:))& '
AllowedOrigins))( 6
,))6 7
builder**  '
=>**( *
{++  !
if,,$ &
(,,& '
Env,,' *
.,,* +
IsDevelopment,,+ 8
(,,8 9
),,9 :
),,: ;
{,,< =
builder--( /
.--/ 0
AllowAnyOrigin--0 >
(--> ?
)--? @
...* +
AllowAnyMethod..+ 9
(..9 :
)..: ;
.//* +
AllowAnyHeader//+ 9
(//9 :
)//: ;
;//; <
}00$ %
else11$ (
{11) *
builder22( /
.22/ 0
WithOrigins220 ;
(22; <
$str22< T
,22T U
$str338 L
,33L M
$str448 Q
,44Q R
$str558 J
,55J K
$str668 K
,66K L
$str778 b
,77b c
$str888 c
,88c d
$str998 ^
,99^ _
$str::8 ^
);;8 9
.<<* +
AllowAnyMethod<<+ 9
(<<9 :
)<<: ;
.<<; <
AllowAnyHeader<<< J
(<<J K
)<<K L
;<<L M
}==$ %
}>>  !
)>>! "
;>>" #
}?? 
)?? 
;?? 
string@@ 

connection@@ 
=@@ 
Configuration@@  -
.@@- .
GetConnectionString@@. A
(@@A B
$str@@B U
)@@U V
;@@V W
stringAA 
dbUrlAA 
=AA 
EnvironmentAA &
.AA& '"
GetEnvironmentVariableAA' =
(AA= >
$strAA> L
)AAL M
;AAM N
ifBB 
(BB 
EnvBB 
.BB 
IsProductionBB  
(BB  !
)BB! "
)BB" #
{CC 
ConsoleDD 
.DD 
WriteDD 
(DD 
$strDD -
)DD- .
;DD. /
}EE 
ifFF 
(FF 
EnvFF 
.FF 
IsProductionFF  
(FF  !
)FF! "
&&FF# %
dbUrlFF& +
!=FF, .
nullFF/ 3
)FF3 4
{GG 
UriHH 
dbUriHH 
=HH 
newHH 
UriHH  #
(HH# $
dbUrlHH$ )
)HH) *
;HH* +
stringII 
usernameII 
=II  !
dbUriII" '
.II' (
UserInfoII( 0
.II0 1
SplitII1 6
(II6 7
$strII7 :
)II: ;
[II; <
$numII< =
]II= >
;II> ?
stringJJ 
passwordJJ 
=JJ  !
dbUriJJ" '
.JJ' (
UserInfoJJ( 0
.JJ0 1
SplitJJ1 6
(JJ6 7
$strJJ7 :
)JJ: ;
[JJ; <
$numJJ< =
]JJ= >
;JJ> ?

connectionKK 
=KK 
$strKK '
+KK( )
usernameKK* 2
+KK3 4
$strKK5 A
+KKB C
passwordKKD L
+KKM N
$strLL %
+LL& '
dbUriLL( -
.LL- .
HostLL. 2
+LL3 4
$strLL5 =
+LL> ?
dbUriLL@ E
.LLE F
PortLLF J
+LLK L
$strLLM Y
+LLZ [
dbUriLL\ a
.LLa b
AbsolutePathLLb n
.LLn o
	SubstringLLo x
(LLx y
$numLLy z
)LLz {
;LL{ |
}NN 
ConsoleOO 
.OO 
WriteOO 
(OO 
$strOO 7
+OO7 8

connectionOO8 B
)OOB C
;OOC D
servicesPP 
.PP 
AddDbContextPP !
<PP! "
GlovoDbContextPP" 0
>PP0 1
(PP1 2
optPP2 5
=>PP6 8
optPP9 <
.PP< =
	UseNpgsqlPP= F
(PPF G

connectionPPG Q
)PPQ R
)PPR S
;PPS T
servicesRR 
.RR 
AddCorsRR 
(RR 
)RR 
;RR 
servicesSS 
.SS 
AddControllersSS #
(SS# $
)SS$ %
;SS% &
servicesUU 
.UU 
AddAutoMapperUU "
(UU" #
	AppDomainUU# ,
.UU, -
CurrentDomainUU- :
.UU: ;
GetAssembliesUU; H
(UUH I
)UUI J
)UUJ K
;UUK L
servicesWW 
.WW 
	AddScopedWW 
<WW 
IRestaurantsServiceWW 2
,WW2 3%
RestApiRestaurantsServiceWW4 M
>WWM N
(WWN O
)WWO P
;WWP Q
servicesXX 
.XX 
	AddScopedXX 
<XX 
IProductsServiceXX /
,XX/ 0"
RestApiProductsServiceXX1 G
>XXG H
(XXH I
)XXI J
;XXJ K
servicesYY 
.YY 
	AddScopedYY 
<YY 
IOrdersServiceYY -
,YY- . 
RestApiOrdersServiceYY/ C
>YYC D
(YYD E
)YYE F
;YYF G
servicesZZ 
.ZZ 
	AddScopedZZ 
<ZZ 
IUsersServiceZZ ,
,ZZ, -
RestApiUsersServiceZZ. A
>ZZA B
(ZZB C
)ZZC D
;ZZD E
services\\ 
.\\ 

AddOptions\\ 
(\\  
)\\  !
;\\! "
services]] 
.]] 
	Configure]] 
<]] 
AppConfiguration]] /
>]]/ 0
(]]0 1
Configuration]]1 >
.]]> ?

GetSection]]? I
(]]I J
$str]]J W
)]]W X
)]]X Y
;]]Y Z
services__ 
.__ "
AddHttpContextAccessor__ +
(__+ ,
)__, -
;__- .
}`` 	
publiccc 
voidcc 
	Configurecc 
(cc 
IApplicationBuildercc 1
appcc2 5
,cc5 6
IWebHostEnvironmentcc7 J
envccK N
)ccN O
{dd 	
ifee 
(ee 
envee 
.ee 
IsDevelopmentee !
(ee! "
)ee" #
)ee# $
{ff 
appgg 
.gg %
UseDeveloperExceptionPagegg -
(gg- .
)gg. /
;gg/ 0
}hh 
appll 
.ll 

UseRoutingll 
(ll 
)ll 
;ll 
appnn 
.nn 
UseCorsnn 
(nn 
AllowedOriginsnn &
)nn& '
;nn' (
apppp 
.pp 
UseCorspp 
(pp 
xpp 
=>pp 
xpp 
.qq 
AllowAnyOriginqq 
(qq  
)qq  !
.rr 
AllowAnyMethodrr 
(rr  
)rr  !
.ss 
AllowAnyHeaderss 
(ss  
)ss  !
)ss! "
;ss" #
appuu 
.uu 
UseAuthenticationuu !
(uu! "
)uu" #
;uu# $
appvv 
.vv 
UseAuthorizationvv  
(vv  !
)vv! "
;vv" #
appxx 
.xx 
UseMiddlewarexx 
<xx 
JwtMiddlewarexx +
>xx+ ,
(xx, -
)xx- .
;xx. /
appzz 
.zz 
UseEndpointszz 
(zz 
	endpointszz &
=>zz' )
{zz* +
	endpointszz, 5
.zz5 6
MapControllerszz6 D
(zzD E
)zzE F
;zzF G
}zzH I
)zzI J
;zzJ K
}{{ 	
}|| 
}}} ã
†/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Utils/AppConfiguration.cs
	namespace 	
glovo_webapi
 
. 
Utils 
{ 
public 

class 
AppConfiguration !
{ 
public 
string 
Secret 
{ 
get "
;" #
set$ '
;' (
}) *
} 
} Ì
ö/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Utils/MailSender.cs
	namespace 	
glovo_webapi
 
. 
Utils 
{ 
public 

static 
class 

MailSender "
{ 
private		 
static		 
readonly		 
string		  &
recoveryMailAccount		' :
=		; <
$str		= V
;		V W
public 
static 
void 
SendRecoveryMail +
(+ ,
User, 0
user1 5
,5 6
string7 =
recoveryToken> K
)K L
{ 	
var 
message 
= 
new 
MimeMessage )
(* +
)+ ,
;, -
message 
. 
From 
. 
Add 
( 
new !
MailboxAddress" 0
(1 2
$str2 N
,N O
recoveryMailAccountP c
)c d
)d e
;e f
message 
. 
To 
. 
Add 
( 
new 
MailboxAddress  .
(/ 0
user0 4
.4 5
Name5 9
,9 :
user; ?
.? @
Email@ E
)E F
)F G
;G H
message 
. 
Subject 
= 
$str >
;> ?
string 
link 
= 
recoveryToken '
;' (
message 
. 
Body 
= 
new 
TextPart '
(( )
$str) 0
)0 1
{2 3
Text 
= 
$str	 à
+
â ä
link
ã è
} 
; 
using 
( 
var 
client 
= 
new  #

SmtpClient$ .
(/ 0
)0 1
)1 2
{3 4
client 
. 
Connect 
(  
$str  0
,0 1
$num2 5
,5 6
false7 <
)< =
;= >
client 
. 
Authenticate #
($ %
$str% >
,> ?
$str@ R
)R S
;S T
client 
. 
Send 
( 
message $
)$ %
;% &
client 
. 

Disconnect !
(" #
true# '
)' (
;( )
} 
} 	
}   
}!! µ&
†/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Utils/PasswordVerifier.cs
	namespace 	
glovo_webapi
 
. 
Utils 
{ 
public 

static 
class 
PasswordVerifier (
{ 
public 
static 
void 
CreatePasswordHash -
(- .
string. 4
password5 =
,= >
out? B
byteC G
[G H
]H I
passwordHashJ V
,V W
outX [
byte\ `
[` a
]a b
passwordSaltc o
)o p
{ 	
if		 
(		 
password		 
==		 
null		  
)		  !
throw		" '
new		( +!
ArgumentNullException		, A
(		A B
$str		B L
)		L M
;		M N
if

 
(

 
string

 
.

 
IsNullOrWhiteSpace

 )
(

) *
password

* 2
)

2 3
)

3 4
throw

5 :
new

; >
ArgumentException

? P
(

P Q
$str	

Q É
,


É Ñ
$str


Ö è
)


è ê
;


ê ë
using 
var 
hmac 
= 
new  
System! '
.' (
Security( 0
.0 1
Cryptography1 =
.= >

HMACSHA512> H
(H I
)I J
;J K
passwordSalt 
= 
hmac 
.  
Key  #
;# $
passwordHash 
= 
hmac 
.  
ComputeHash  +
(+ ,
System, 2
.2 3
Text3 7
.7 8
Encoding8 @
.@ A
UTF8A E
.E F
GetBytesF N
(N O
passwordO W
)W X
)X Y
;Y Z
} 	
public 
static 
bool 
VerifyPasswordHash -
(- .
string. 4
password5 =
,= >
byte? C
[C D
]D E

storedHashF P
,P Q
byteR V
[V W
]W X

storedSaltY c
)c d
{ 	
if 
( 
password 
== 
null  
)  !
throw" '
new( +!
ArgumentNullException, A
(A B
$strB L
)L M
;M N
if 
( 
string 
. 
IsNullOrWhiteSpace )
() *
password* 2
)2 3
)3 4
throw5 :
new; >
ArgumentException? P
(P Q
$str	Q É
,
É Ñ
$str
Ö è
)
è ê
;
ê ë
if 
( 

storedHash 
. 
Length !
!=" $
$num% '
)' (
throw) .
new/ 2
ArgumentException3 D
(D E
$strE {
,{ |
$str	} ã
)
ã å
;
å ç
if 
( 

storedSalt 
. 
Length !
!=" $
$num% (
)( )
throw* /
new0 3
ArgumentException4 E
(E F
$strF }
,} ~
$str	 ç
)
ç é
;
é è
using 
var 
hmac 
= 
new  
System! '
.' (
Security( 0
.0 1
Cryptography1 =
.= >

HMACSHA512> H
(H I

storedSaltI S
)S T
;T U
var 
computedHash 
= 
hmac #
.# $
ComputeHash$ /
(/ 0
System0 6
.6 7
Text7 ;
.; <
Encoding< D
.D E
UTF8E I
.I J
GetBytesJ R
(R S
passwordS [
)[ \
)\ ]
;] ^
for 
( 
int 
i 
= 
$num 
; 
i 
< 
computedHash  ,
., -
Length- 3
;3 4
i5 6
++6 8
)8 9
{ 
if 
( 
computedHash  
[  !
i! "
]" #
!=$ &

storedHash' 1
[1 2
i2 3
]3 4
)4 5
return6 <
false= B
;B C
} 
return 
true 
; 
}   	
}!! 
}"" ã@
•/media/ruben/Almacenamiento HDD/Clase/Ingenier√≠a Inform√°tica/software-engineering-assignatura/Glovo/server/glovo_webapi/glovo_webapi/Utils/TokenCreatorValidator.cs
	namespace		 	
glovo_webapi		
 
.		 
Utils		 
{

 
public 

class 
TokenCreationParams $
{ 
public 
string 
TokenStr 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 
byte 
[ 
] 
	SaltBytes 
{  !
get" %
;% &
set' *
;* +
}, -
public 
TokenCreationParams "
(" #
string# )
tokenStr* 2
,2 3
byte4 8
[8 9
]9 :
	saltBytes; D
)D E
{ 	
TokenStr 
= 
tokenStr 
;  
	SaltBytes 
= 
	saltBytes !
;! "
} 	
} 
public 

class !
TokenValidationParams &
{ 
public 
int 
UserId 
{ 
get 
;  
set! $
;$ %
}& '
public 
byte 
[ 
] 
	SaltBytes 
{  !
get" %
;% &
set' *
;* +
}, -
public !
TokenValidationParams $
($ %
int% (
userId) /
,/ 0
byte1 5
[5 6
]6 7
	saltBytes8 A
)A B
{ 	
UserId 
= 
userId 
; 
	SaltBytes 
= 
	saltBytes !
;! "
}   	
}!! 
public## 

class## !
TokenCreatorValidator## &
{$$ 
private%% 
readonly%% 
string%% 
_encodingKey%%  ,
;%%, -
public'' !
TokenCreatorValidator'' $
(''$ %
string''% +
encodingKey'', 7
)''7 8
{(( 	
_encodingKey)) 
=)) 
encodingKey)) &
;))& '
}** 	
public,, 
TokenCreationParams,, "
CreateToken,,# .
(,,. /
int,,/ 2
userId,,3 9
,,,9 :
int,,; >
expirationMinutes,,? P
),,P Q
{-- 	
var.. 
	saltBytes.. 
=.. 
new.. 
byte..  $
[..$ %
$num..% '
]..' (
;..( )
using// 
(// 
var// 
	generator//  
=//! "
new//# &$
RNGCryptoServiceProvider//' ?
(//? @
)//@ A
)//A B
{00 
	generator11 
.11 
GetBytes11 "
(11" #
	saltBytes11# ,
)11, -
;11- .
}22 
var44 
tokenHandler44 
=44 
new44 "#
JwtSecurityTokenHandler44# :
(44: ;
)44; <
;44< =
var55 
key55 
=55 
Encoding55 
.55 
ASCII55 $
.55$ %
GetBytes55% -
(55- .
_encodingKey55. :
)55: ;
;55; <
var66 
tokenDescriptor66 
=66  !
new66" %#
SecurityTokenDescriptor66& =
{77 
Subject88 
=88 
new88 
ClaimsIdentity88 ,
(88, -
new88- 0
[880 1
]881 2
{883 4
new99 
Claim99 
(99 
$str99 "
,99" #
userId99$ *
.99* +
ToString99+ 3
(993 4
)994 5
)995 6
,996 7
new:: 
Claim:: 
(:: 
$str:: $
,::$ %
Encoding::& .
.::. /
Default::/ 6
.::6 7
	GetString::7 @
(::@ A
	saltBytes::A J
)::J K
)::K L
,::L M
};; 
);; 
,;; 
IssuedAt<< 
=<< 
DateTime<< #
.<<# $
UtcNow<<$ *
,<<* +
Expires== 
=== 
DateTime== "
.==" #
UtcNow==# )
.==) *

AddMinutes==* 4
(==4 5
expirationMinutes==5 F
)==F G
,==G H
SigningCredentials>> "
=>># $
new>>% (
SigningCredentials>>) ;
(>>; <
new??  
SymmetricSecurityKey?? ,
(??, -
key??- 0
)??0 1
,??1 2
SecurityAlgorithms@@ &
.@@& '
HmacSha256Signature@@' :
)AA 
}BB 
;BB 
varCC 
tokenCC 
=CC 
tokenHandlerCC $
.CC$ %
CreateTokenCC% 0
(CC0 1
tokenDescriptorCC1 @
)CC@ A
;CCA B
varDD 
tokenStrDD 
=DD 
tokenHandlerDD '
.DD' (

WriteTokenDD( 2
(DD2 3
tokenDD3 8
)DD8 9
;DD9 :
returnFF 
newFF 
TokenCreationParamsFF *
(FF* +
tokenStrFF+ 3
,FF3 4
	saltBytesFF5 >
)FF> ?
;FF? @
}GG 	
publicII !
TokenValidationParamsII $
ValidateTokenII% 2
(II2 3
stringII3 9
tokenStrII: B
)IIB C
{JJ 	
varKK 
tokenHandlerKK 
=KK 
newKK "#
JwtSecurityTokenHandlerKK# :
(KK: ;
)KK; <
;KK< =
varLL 
keyLL 
=LL 
EncodingLL 
.LL 
ASCIILL $
.LL$ %
GetBytesLL% -
(LL- .
_encodingKeyLL. :
)LL: ;
;LL; <
tokenHandlerMM 
.MM 
ValidateTokenMM &
(MM& '
tokenStrMM' /
,MM/ 0
newMM1 4%
TokenValidationParametersMM5 N
{NN $
ValidateIssuerSigningKeyOO (
=OO) *
trueOO+ /
,OO/ 0
IssuerSigningKeyPP  
=PP! "
newPP# & 
SymmetricSecurityKeyPP' ;
(PP; <
keyPP< ?
)PP? @
,PP@ A
ValidateIssuerQQ 
=QQ  
falseQQ! &
,QQ& '
ValidateAudienceRR  
=RR! "
falseRR# (
,RR( )
	ClockSkewSS 
=SS 
TimeSpanSS $
.SS$ %
ZeroSS% )
}TT 
,TT 
outTT 
SecurityTokenTT  
validatedTokenTT! /
)TT/ 0
;TT0 1
varUU 
jwtTokenUU 
=UU 
(UU 
JwtSecurityTokenUU ,
)UU, -
validatedTokenUU- ;
;UU; <
varWW 
userIdWW 
=WW 
intWW 
.WW 
ParseWW "
(WW" #
jwtTokenWW# +
.WW+ ,
ClaimsWW, 2
.WW2 3
FirstWW3 8
(WW8 9
xWW9 :
=>WW; =
xWW> ?
.WW? @
TypeWW@ D
==WWE G
$strWWH L
)WWL M
.WWM N
ValueWWN S
)WWS T
;WWT U
varXX 
saltStrXX 
=XX 
jwtTokenXX "
.XX" #
ClaimsXX# )
.XX) *
FirstXX* /
(XX/ 0
xXX0 1
=>XX2 4
xXX5 6
.XX6 7
TypeXX7 ;
==XX< >
$strXX? E
)XXE F
.XXF G
ValueXXG L
;XXL M
byteYY 
[YY 
]YY 
	saltBytesYY 
=YY 
EncodingYY '
.YY' (
DefaultYY( /
.YY/ 0
GetBytesYY0 8
(YY8 9
saltStrYY9 @
)YY@ A
;YYA B
return[[ 
new[[ !
TokenValidationParams[[ ,
([[, -
userId[[- 3
,[[3 4
	saltBytes[[5 >
)[[> ?
;[[? @
}\\ 	
}]] 
}^^ 