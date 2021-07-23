import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy",
                  style: TextStyle(
                     fontFamily: "Quicksand",
                  ),),
        backgroundColor: Colors.blueGrey.shade900,
      ),
        body: SingleChildScrollView(child: Column(
            children: [
              Stack(
                   children: [
                     Padding(
                       padding: EdgeInsets.only(
                         top:149
                       ),
                       child: Container(
                         height: 4,
                         width: 160,
                         decoration: BoxDecoration(
                           color: Colors.orange,
                         ),
                       ),
                     ),
                     Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade900
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 65,
                      left: 28
                    ),
                    child: Text("Battle Warriors Privacy Policy", style: TextStyle(
                      color: Colors.white,fontFamily: "Quicksand",
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    )),
                  ),
                ),
                   ], 
              ),
              Container(
                height: 505,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade200
                ),
                child:  SingleChildScrollView(
                                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("We, Battle Warriors e-Sports understand the importance of maintaining privacy and thus abide by the highest standards for securing customer information privacy.\nThis Privacy Policy explains how Battle Warriors e-Sports  distinctly informs our users about the type of information we collect from our users, the reason for collecting such information, how we intend on using such information and the choices available to our customers regarding our use of such information. We will not use its affiliates collect, use, and share information from or about you when you use our websites, downloadable applications such as games, interactive mobile applications, and voice-activated assistants, and other services that link to this policy or share your information with anyone except as described in this Privacy Policy.Battle Warriors e-Sports operates the portal in India, which offers participation in the various contests, games (including fantasy games (Game) (“GAMING FACILITIES”) being conducted on the Portal) shall be bound by this Privacy Policy.\nPlease read our Policy carefully to understand how we treat the information provided by you. By clicking on the “Accept” button, you are agreeing to the collection, use, disclosure, retention and protection of your Personal Information as provided in this Policy. However, if you do not consent to any of the terms enumerated in this Policy, you may choose not to use our services by clicking on the “Decline” button. However, please be aware that if you do not allow us to collect the Personal Information as enumerated in this Policy, we may not be able to provide you with certain services. Battle Warriors respects the privacy of its Users and is committed to protect it in all respects. With a view to offer an elevating and complete internet experience to its Users, Battle Warriors offers a vast source of GAMING FACILITIES. Kindly take time to read the 'About Us' section to know more about Battle Warriors. Most of the GAMING FACILITIES are offered for free but you may need registration to participate in Battle Warriors online games. The information about the User is collected by Battle Warriors as (i) information supplied by Users and (ii) information automatically tracked during User's navigation on our portal. Before you submit any information to the Portal, please read this Privacy Policy for an explanation of how we will treat your personal information. By using any part of the Portal, you consent to the collection, use, disclosure and transfer of your personal information for the purposes outlined in this Privacy Policy and to the collection, processing and maintenance of this information. If you do not agree to this Privacy Policy, please do not use the Portal. Your use of any part of the Portal indicates your acceptance of this Privacy Policy and of the collection, use and disclosure of your personal information in accordance with this Privacy Policy. While you have the option not to provide us with certain information or withdraw consent to collect certain information, kindly note that in such an event you may not be able to take full advantage of the entire scope of features and services offered to you and we reserve the right not to provide you with our services.", style: TextStyle(
                          color: Colors.blueGrey.shade900,fontFamily: "Quicksand",
                          fontSize: 15
                        ),),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                       Text("Purpose and Usage:", style: TextStyle(
                          fontSize: 25,
                          color: Colors.blueGrey.shade900,fontFamily: "Quicksand",
                        ),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("To avail certain GAMING FACILITIES on the Portal, Users would be required to provide certain information for the registration process namely:", style: TextStyle(
                            color: Colors.blueGrey.shade900,fontFamily: "Quicksand",
                            fontSize: 15

                          ),),
                        ),
                        
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(children: [
                                Icon(Icons.arrow_forward_ios),
                                SizedBox(width: 4,),
                                Text("Email address",
                  style: TextStyle(
                     fontFamily: "Quicksand",
                  ),),
                              ],),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(children: [
                                Icon(Icons.arrow_forward_ios),
                                SizedBox(width: 4,),
                                Text("Password",
                  style: TextStyle(
                     fontFamily: "Quicksand",
                  ),),
                              ],),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(children: [
                                Icon(Icons.arrow_forward_ios),
                                SizedBox(width: 4,),
                                Text("Facebook",
                  style: TextStyle(
                     fontFamily: "Quicksand",
                  ),),
                              ],),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("In the course of providing you with access to the GAMING FACILITIES, and in order to provide you access to the features and services offered through the Portal and to verify your identity, you may be required to furnish additional information, including your Permanent Account Number. In the course of providing the GAMING FACILITIES, Users may invite other existing Users or other users (Invited Users) to participate in any of the GAMING FACILITIES by providing the email address or Facebook username of such users. Battle Warriors may thereafter use this information to contact the Invited User and invite such user to register with Battle Warriors (if such Invited User is not an existing User) and participate in the Game/GAMING FACILITY in relation to which such person was invited by the User. The participation of the Invited User in any of the GAMING FACILITIES shall be subject to the terms of this Privacy Policy and the Terms and Conditionsfor the use of the Portal. The User hereby represents that the Invited Users have consented and agreed to such disclosure to and use of their email address and Facebook username by Battle Warriors. All required information is specific and based on the kind of Game/ GAMING FACILITY the User wishes to participate in or access and will be utilized for the purpose of providing services, including but not limited to the GAMING FACILITY, requested by the User. The information as supplied by the Users enables us to improve the GAMING FACILITIES and provide you the most user-friendly game experience. Battle Warriors may also share such information with affiliates and third parties in limited circumstances, including for the purpose of providing services requested by the User, complying with legal process, preventing fraud or imminent harm, and ensuring the security of our network and services.When you use the Battle Warriors Services, you agree to the collection, use, and sharing of your information as described in this Privacy Policy.", style: TextStyle(
                            color: Colors.blueGrey.shade900,fontFamily: "Quicksand",
                            fontSize: 15

                          ),),
                        ),
                        Text("Types of Information We Collect", style: TextStyle(
                          fontSize: 25,fontFamily: "Quicksand",
                          color: Colors.blueGrey.shade900,
                        ),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("For a more interactive Portal, and advanced efficiency in our services, we, or our service providers, on our behalf, may require Users to provide us with certain personally identifiable information such as Name, Address, Date of Birth,Telephone Number, Email Address, Demographic or Biographical Information, Gender, Interests, Photos, Credit/Debit Card details. In addition to the aforesaid, If you contact us by phone, we may record the conversation and/or keep a summary of the phone call.", style: TextStyle(
                            color: Colors.blueGrey.shade900,fontFamily: "Quicksand",
                            fontSize: 15

                          ),),
                        ),
                        Text("Information from Third Party Sources", style: TextStyle(
                          fontSize: 25,fontFamily: "Quicksand",
                          color: Colors.blueGrey.shade900,
                        ),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("o   Public Information: from publicly and commercially available online or offline sources, as permitted by law including demographic information, purchasing data, membership in loyalty programs or information about advertisements you have seen or acted upon, including your interaction with advertisers’ products and services.\no	  Social Media Information: if you visit the Battle Warriors Services on a device on which you also use social networks or if you interact with us through a social media service or other platform, we may have access to some information you provide to that social network or platform such as your name, email address, friend list, photo, age, gender, location, birthday, social networking ID, current city, and the people/sites you follow.", style: TextStyle(
                            color: Colors.blueGrey.shade900,fontFamily: "Quicksand",
                            fontSize: 15

                          ),),
                        ),
                        Text("YOUR RIGHTS AND CHOICES", style: TextStyle(
                          fontSize: 25,fontFamily: "Quicksand",
                          color: Colors.blueGrey.shade900,
                        ),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Communication Preferences and Opt-outs\n You may unsubscribe from our email newsletters or promotional emails by following the opt-out instructions contained in the email.\nCookies and Similar Technologies\nWe, and our service providers, advertisers, and other partners, use cookies and similar technologies (e.g., web beacons, pixels, ad tags and device identifiers) to recognize you and/or your device(s) on, off and across different Battle Warriors Services and devices. Our Cookies and Tracking Technologies policy provides certain opt-out choices. However, our systems may still collect usage data for certain other inherent purposes (e.g., contextual advertising, research, analytics, and internal operations). Unless the User voluntarily identifies himself/herself (e.g., through registration), Battle Warriors has no way of knowing who the User is, even if we assign a cookie to the User's computer. The only personal information a cookie can contain is information supplied by the User. A cookie cannot read data off the User's hard drive. Battle Warriors advertisers may also assign their own cookies to the User's browser (if the User clicks on their ad banners), a process that Battle Warriors  does not control.\nOther Online Services\nBattle Warriors Services may not contain links to third party websites and services.", style: TextStyle(
                            color: Colors.blueGrey.shade900,fontFamily: "Quicksand",
                            fontSize: 15

                          ),),
                        ),
                        // Column(
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: Row(children: [
                        //         Icon(Icons.arrow_forward_ios),
                        //         SizedBox(width: 4,),
                        //         Text("To facilitate our Service;",style: TextStyle(fontFamily: "Quicksand",
                        //   color: Colors.blueGrey.shade900,
                        // ),),
                        //       ],),
                        //     ),
                        //     Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: Row(children: [
                        //         Icon(Icons.arrow_forward_ios),
                        //         SizedBox(width: 4,),
                        //         Text("To provide the Service on our behalf;",style: TextStyle(fontFamily: "Quicksand",
                        //   color: Colors.blueGrey.shade900,
                        // ),),
                        //       ],),
                        //     ),
                        //     Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: Row(children: [
                        //         Icon(Icons.arrow_forward_ios),
                        //         SizedBox(width: 4,),
                        //         Text("To perform Service-related services; or",style: TextStyle(fontFamily: "Quicksand",
                        //   color: Colors.blueGrey.shade900,
                        // ),),
                        //       ],),
                        //     ),
                        //     Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: Row(children: [
                        //         Icon(Icons.arrow_forward_ios),
                        //         SizedBox(width: 4,),
                        //         Text("To assist us in analyzing how our Service is used.",style: TextStyle(fontFamily: "Quicksand",
                        //   color: Colors.blueGrey.shade900,
                        // ),),
                        //       ],),
                        //     ),
                        //   ],
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Text("We want to inform users of this Service that these third parties have access to your Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.", style: TextStyle(
                        //     color: Colors.blueGrey.shade900,fontFamily: "Quicksand",
                        //     fontSize: 15

                        //   ),),
                        // ),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text("How long will we retain your personal information", style: TextStyle(
                            fontSize: 25,fontFamily: "Quicksand",
                            color: Colors.blueGrey.shade900,
                        ),),
                         ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("We shall retain the Personal Information provided by Users for only as long as it is necessary for the purposes set out in this Policy, for as long as the Users account is active or as needed to provide the services to the Users. Keep in mind that even though our systems are designed to carry out deletion of information as per the above guidelines, we are not liable for the non-deletion of certain data within a specific time frame due to technological constraints.", style: TextStyle(
                            color: Colors.blueGrey.shade900,fontFamily: "Quicksand",
                            fontSize: 15

                          ),),
                        ),
                        Text("WITHDRAWAL OF CONSENT:", style: TextStyle(
                          fontSize: 25,fontFamily: "Quicksand",
                          color: Colors.blueGrey.shade900,
                        ),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("If you have given your free consent to the collection, use, disclosure, retention and protection of your Personal Information, and wish to withdraw such consent, you may do so by contacting us at any time.Not with standing the above provisions, any decision by you to opt-out, rectify or erase information from our records or withdraw your consent shall not in any manner whatsoever affect and/or make illegal processing of your information done prior to the communication of your aforesaid decision to us.", style: TextStyle(
                            color: Colors.blueGrey.shade900,fontFamily: "Quicksand",
                            fontSize: 15

                          ),),
                        ),
                        Text("How we protect your information", style: TextStyle(
                          fontSize: 25,
                          color: Colors.blueGrey.shade900,fontFamily: "Quicksand",
                        ),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("We maintain procedural, technical, and physical safeguards for the Battle Warriors Services to help protect against loss, misuse or unauthorized access, disclosure, alteration, or destruction of the information you provide via the Battle Warriors Services. All information gathered on Battle Warriors is securely stored within Battle Warriors controlled database. These safeguards vary depending upon the sensitivity of the information we collect and store. Please be aware that no security solutions are infallible. The database is stored on servers secured behind a firewall; access to such servers being password-protected and strictly limited based on need-to-know basis, we cannot guarantee the security of our database, nor can we guarantee that information you supply will not be intercepted while being transmitted to us over the Internet. Further, any information you include in a posting to the discussion areas will be available to anyone with Internet access. By using the Portal, you understand and agree that your information may be used in or transferred to countries other than India.", style: TextStyle(
                            color: Colors.blueGrey.shade900,fontFamily: "Quicksand",
                            fontSize: 15

                          ),),
                        ),
                        Text("Updates to our privacy policy", style: TextStyle(
                          fontSize: 25,fontFamily: "Quicksand",
                          color: Colors.blueGrey.shade900,
                        ),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("If we make material changes to the way we collect or use your information, we will notify you by posting a revised version of this Privacy Policy online, and we may also notify you by other means. You should check the Battle Warriors Services periodically for updates.\nThe date at the top of the Privacy Policy tells you when it was last updated. Any changes to this Privacy Policy will become effective when the revised Privacy Policy is posted. If you use this online service after the changes are posted, you have agreed the changes. If you do not agree with this Privacy Policy or any changes we make, please do not continue to use the Battle Warriors Services.", style: TextStyle(
                            color: Colors.blueGrey.shade900,fontFamily: "Quicksand",
                            fontSize: 15

                          ),),
                        ),
                         Text("Contact Us", style: TextStyle(
                          fontSize: 25,fontFamily: "Quicksand",
                          color: Colors.blueGrey.shade900,
                        ),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us at gamershubcontest@gmail.com.", style: TextStyle(
                            color: Colors.blueGrey.shade900,fontFamily: "Quicksand",
                            fontSize: 15

                          ),),
                        ),
                    ],
                  ),
                )
            ,
              ),
             ],
        )),
    );
  }
}