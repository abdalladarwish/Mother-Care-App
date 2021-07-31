import 'models/data_model/resource.dart';

List<Section> data = [
  Section('COVID-19', [
    Subsection('What is COVID-19', [
      'Coronavirus disease 2019 (COVID-19) is defined as illness caused by a novel coronavirus now called severe acute respiratory syndrome coronavirus 2 (SARS-CoV-2; formerly called 2019-nCoV), which was first identified amid an outbreak of respiratory illness cases in Wuhan City, Hubei Province, China.It was initially reported to the WHO on December 31, 2019. On January 30, 2020, the WHO declared the COVID-19 outbreak a global health emergency.On March 11, 2020, the WHO declared COVID-19 a global pandemic, its first such designation since declaring H1N1 influenza a pandemic in 2009.',
      ImageContent('assets/images/covid19.png'),
    ]),
    Subsection('COVID-19 signs', [
      HtmlData('''
      COVID-19 affects different people in different ways. Most infected people will develop mild to moderate illness and recover without hospitalization.<br>
      Most common symptoms:<br>
      <ul>
      <li><span>Fever</span></li> 
      <li><span>Dry cough</span></li>
      <li><span>Tiredness</span></li>  
      </ul>
      Less common symptoms:<br>
      <ul>
      <li><span>Aches and pains</span></li>
      <li><span>Sore throat</span></li>
      <li><span>Diarrhea</span></li> 
      <li><span>Conjunctivitis</span></li>
      <li><span>Headache</span></li>
      <li><span>Loss of taste or smell</span></li>
      <li><span>A rash on skin, or discoloration of fingers or toes</span></li> 
      </ul>
      <b>Serious symptoms:</b><br>
      <ul>
      <li><span>Difficulty breathing or shortness of breath</span></li>
      <li><span>Chest pain or pressure</span></li>
      <li><span>Loss of speech or movement</span></li> 
      </ul>
      Seek immediate medical attention if you have serious symptoms. Always call before visiting your doctor or health facility.<br>
      People with mild symptoms who are otherwise healthy should manage their symptoms at home.On average it takes 5–6 days from when someone is infected with the virus for symptoms to show, however it can take up to 14 days.
     <iframe src="https://www.youtube.com/embed/DNeYfUTA11s" allow="accelerometer; autoplay" allowfullscreen>
     </iframe>
      '''),
    ]),
    Subsection('How to deal with COVID-19', [
      HtmlData('''To prevent infection and to slow transmission of COVID-19, do the following:<br>
      <ul>
      <li><span>Wash your hands regularly with soap and water or clean them with alcohol-based hand rub.</span></li>
      <li><span>Maintain at least 1-meter distance between you and people coughing or sneezing.</span></li>
      <li><span>Avoid touching your face.</span></li>
      <li><span>Cover your mouth and nose when coughing or sneezing.</span></li>
      <li><span>Stay home if you feel unwell.</span></li>
      <li><span>Refrain from smoking and other activities that weaken the lungs.</span></li>
      <li><span>Practice physical distancing by avoiding unnecessary travel and staying away from large groups of people.</span></li> 
      </ul>
      '''),
    ]),
    Subsection('Masks', [
      HtmlData('Masks should be used as part of a comprehensive strategy of measures to suppress transmission and save lives; the use of a mask alone is not sufficient to provide an adequate level of protection against COVID-19.<br>If COVID-19 is spreading in your community, stay safe by taking some simple precautions, such as physical distancing, wearing a mask, keeping rooms well ventilated, avoiding crowds, cleaning your hands, and coughing into a bent elbow or tissue. Check local advice where you live and work.<b>Do it all!</b>'),
      VideoContent('UmUxYGKA7as'),
      HtmlData('<b>Best types of masks</b>'),
      VideoContent("DNeYfUTA11s"),
    ]),
    Subsection('Medical Instructions', [
      ImageContent("assets/images/covid-medical-instructions.png")
    ]),
    Subsection('Quarantine Instructions', [
      VideoContent("YZnnnGheZJU")
    ]),
    Subsection('Hot Line', [])
  ]),
  Section('Labor and Delivery', [
    Subsection('Labor Stages', [
      ImageContent("assets/images/labor-stages.jpg"),
      HtmlData('''<h2>What are stages of labor?</h2>
      Labor (also called childbirth) is the process of your baby leaving the uterus (womb). Labor is divided into three stages:<br>
      <ol>
      <li>Labor</li>
      <li>Pushing and birth</li>
      <li>Delivery of the placenta</li>
      </ol>
      Every woman’s labor is different. And your labor may be different each time you have a baby. But there are patterns to labor that are true for most women. Learning about the stages of labor and what happens during each one can help you know what to expect once labor begins
      ''')
    ]),
    Subsection('1st stage of labor', [
      HtmlData('''
      The first stage of labor is the longest stage. For first-time moms, it can last from 12 to 19 hours . It may be shorter (about 14 hours) for moms who’ve already had children.
      It’s when contractions become strong and regular enough to cause your cervix to dilate (open) and thin out (efface). This lets your baby move lower into your pelvis and into your birth canal (vagina). This stage of labor ends when you are 10 centimeters dilated. The first stage is divided into three parts: early labor, active labor and transition to stage 2 of labor.<br>
      <b>Transition to the second stage of labor</b><br>This can be the toughest and most painful part of labor. It can last 15 minutes to an hour. During the transition:
      <ul>
      <li><span>Contractions come closer together and can last 60 to 90 seconds. You may feel like you want to bear down</span></li>
      <li><span>You may feel a lot of pressure in your lower back and rectum. If you feel like you want to push, tell your provider</span></li>
      </ul>
      '''),
    ]),
    Subsection('2nd stage of labor', [
      HtmlData('''
      In the second stage of labor, your cervix is fully dilated and ready for childbirth. This stage is the most work for you because your provider wants you to start pushing your baby out. This stage can be as short as 20 minutes or as long as a few hours. It may be longer for first-time moms or if you’ve had an epidural. And epidural is pain medicine you get through a tube in your lower back that helps numb your lower body during labor. It's the most common kind of pain relief used during labor. The second stage ends when your baby is born.<br>
      <br>
      During the second stage of labor:<br>
      <ul>
      <li><span>Your contractions may slow down to come every 2 to 5 minutes apart. They last about 60 to 90 seconds.</span></li>
      <li><span>You may get an episiotomy. This is a small cut made at the opening of the vagina to help let the baby out. Most women don't need an episiotomy.</span></li>
      <li><span>Your baby’s head begins to show. This is called crowning.</span></li>
      <li><span>Your provider guides your baby out of the birth canal. She may use special tools, like forceps or suction, to help your baby out.</span></li>
      <li><span>Your baby is born, and the umbilical cord is cut.</span></li>
      </ul><br>
       Instructions about who’s cutting the umbilical cord are in your birth plan. What you can do:<br>
       <ol>
       <li>Find a position that is comfortable for you. You can squat, sit, kneel or lie back.</li>
       <li>Push during contractions and rest between them. Push when you feel the urge or when your provider tells you.</li>
       <li>If you’re uncomfortable or pushing has stopped, try a new position.</li>
       </ol>
      ''')
    ]),
    Subsection('3rd stage of labor', [
      HtmlData('''<br>
      In the third stage of labor, the placenta is delivered. The placenta grows in your uterus and supplies your baby with food and oxygen through the umbilical cord. This stage is the shortest and usually doesn’t take more than 20 minutes.<br>
      During the third stage of labor:<br>
      <ul>
      <li><span>You have contractions that are closer together and not as painful as earlier. These contractions help the placenta separate from the uterus and move into the birth canal. They begin 5 to 30 minutes after birth.</span></li>
      <li><span>You continue to have contractions even after the placenta is delivered. You may get medicine to help with contractions and to prevent heavy bleeding.</span></li>
      <li><span>Your provider squeezes and presses on your belly to make sure the uterus feels right.</span></li>
      <li><span>If you had an episiotomy, your provider repairs it now.</span></li>
      <li><span>If you’re storing your <a href="https://www.marchofdimes.org/pregnancy/umbilical-cord-blood.aspx">umbilical cord blood</a>, your provider collects it now. Umbilical cord blood is blood left in the umbilical cord and placenta after your baby is born and the cord is cut. Some moms and families want to store or donate umbilical cord blood so it can be used later to treat certain diseases, like cancer. Your instructions about umbilical cord blood can be part of your birth plan</li>
      <li><span>You may have chills or feel shaky. Tell your provider if these are making you uncomfortable.</span></li>
      </ul>
      What you can do:<br>
      <ul>
      <li><span>Enjoy the first few moments with your baby.</span></li>
      <li><span>Start breastfeeding. Most women can start breastfeeding within 1 hour of their baby’s birth.</span></li>
      <li><span>Give yourself a big pat on the back for all your hard work. You've made it through childbirth!</span></li>
      </ul>
      ''')
    ]),
    Subsection('Vaginal Delivery', [
      HtmlData('''
      When a baby is born through the birth canal of a woman’s body, the delivery is termed as a vaginal delivery. It may or may not be assisted with epidurals or pain-relieving medication. The exact time of birth cannot be predicted in such a case, but most vaginal births tend to happen once 40 weeks of pregnancy have been completed.<br/>
Most doctors recommend a vaginal birth if there is a possibility for it and advise against going for caesarean delivery. During the stress of labour pains, the baby secretes hormones for the development of its brain and lungs; moreover,passaging through the birth canal squeezes the baby’s chest to clear all amniotic fluid and expand its lungs effectively. For mothers planning to have multiple children, vaginal births are highly recommended. When done with an incision above the anal area, the procedure is called <a href="https://parenting.firstcry.com/articles/episiotomy-all-you-need-to-know">episiotomy</a>.
      ''')
    ]),
    Subsection('Natural Childbirth', [
      HtmlData('''This is one of the types of birth that is steadily gaining popularity. In this method, there are no medical procedures or invasive therapies involved, and the process takes place in the most natural manner possible. This is mostly a personal choice and the mother needs to be committed throughout the way.<br/>
      Various exercises and positions are taken into account while carrying out delivery in natural ways. A midwife usually stays with the mother to ensure the delivery is successful and the mother is in good spirits. The delivery can take place at the hospital or even at home, with all preparations done beforehand.<br/>
      Natural birth can be extremely empowering for a mother. Having <a href="https://parenting.firstcry.com/articles/kangaroo-mother-care-kmc">skin-to-skin contact</a>with the baby immediately after delivery can foster a strong bond between the mother and the child. It also triggers hormones in the body that start producing milk in the breasts right away.
      ''')
    ]),
    Subsection('Caesarean Delivery', [
      HtmlData('''
      Things don’t always go according to plan. A mother might want to undertake vaginal delivery but if complications arise, <a href="https://parenting.firstcry.com/articles/caesarean-delivery-c-section-birth">caesarean delivery</a> is an option that might have to be taken.<br/>
      In this method, the baby is delivered by opening up the abdomen of the mother and surgically opening the uterus to remove the baby. The name is derived from the Latin word ‘caedare’, which means ‘to cut’. Hence, this type of the cut is called a C-section – thats how the delivery method gets its name.<br/>
      Many mothers decide to have a caesarean delivery in advance, which allows the hospital and doctors to start making preparations accordingly. This could be out of choice or even after a sonography has revealed certain parameters which make it necessary to undertake a C-section, such as the presence of <a href="https://parenting.firstcry.com/articles/multiple-pregnancy-causes-symptoms-risks-more">twins or triplets</a>, breech or transverse presentation, or a very large baby.<br/>
      In other cases, if vaginal delivery fails even after a good trial of labour or if any <a href="https://parenting.firstcry.com/articles/10-complications-during-labour-and-delivery">complication</a> arises, such as breech position while delivering , meconium stained liquor or obstruction in the birth canal, the doctors will have to quickly resort to undertaking a C-section and removing the baby out of the uterus in time.
      ''')
    ]),
    Subsection('Forceps Delivery', [
      HtmlData('''
      This is a rather peculiar type of delivery method and is required in certain cases of vaginal birth. This is an assistance to the usual vaginal delivery when the baby is on its way via the birth canal but fails to fully emerge out. This could be because of small obstructions, or the mother being tired and exhausted and hence being unable to push the baby out.<br/><br/>
      In these cases, the doctor makes use of specially created tongs which resemble <a href="https://parenting.firstcry.com/articles/assisted-delivery-forceps-and-ventouse">forceps</a>,and inserts them slowly into the birth canal. These are then used to gently grab the baby’s head and guide it outwards through the canal.
      ''')
    ]),
    Subsection('Vacuum Extraction', [
      HtmlData('''
      Similar to the forceps delivery method, this delivery technique is used in the case of a vaginal birth. For example, if the baby is on its way out but has stopped moving further down the canal, the vacuum extraction method is applied.<br/>
      The doctors make use of a specialized vacuum pump which is inserted up to the baby via the canal. The vacuum end has a soft cup which is placed on the top of the baby’s head. Vacuum is created so that the cup holds the head, and the baby is gently guided outwards through the canal.
      ''')
    ]),
  ]),
  Section('Breast Feeding', [
    Subsection('Lactation', [
      HtmlData('''
      Changes early in <a href="https://en.wikipedia.org/wiki/Pregnancy">pregnancy</a> prepare the breast for lactation. Before pregnancy the breast is largely composed of
      <a href="https://en.wikipedia.org/wiki/Adipose_tissue">adipose</a>(fat) tissue but under the influence of the hormones
      <a href="https://en.wikipedia.org/wiki/Estrogen">estrogen</a>, <a href="https://en.wikipedia.org/wiki/Progesterone">progesterone</a>,
      <a href="https://en.wikipedia.org/wiki/Prolactin">prolactin</a> and other hormones, the breasts prepare for production of milk for the baby.
      There is an increase in blood flow to the breasts. Pigmentation of the nipples and
      <a href="https://en.wikipedia.org/wiki/Areola">areola</a> also increases. Size increases as well, but breast size is not related to the amount of milk that the mother will be able to produce after the baby is born. 
      By the second trimester of pregnancy <a href="https://en.wikipedia.org/wiki/Colostrum">colostrum</a> , a thick yellowish fluid, begins to be produced in the alveoli and continues to be produced for the first few days after birth until the milk "comes in", around 30 to 40 hours after delivery.
      <a href="https://en.wikipedia.org/wiki/Oxytocin">oxytocin</a> contracts the <a href="https://en.wikipedia.org/wiki/Smooth_muscle">smooth_muscle</a> of the <a href="https://en.wikipedia.org/wiki/Uterus">uterus</a>
      uring birth and following delivery, called the <a href="https://en.wikipedia.org/wiki/Postpartum_period">postpartum period</a>, while breastfeeding.
      Oxytocin also contracts the smooth muscle layer of band-like cells surrounding the alveoli to squeeze the newly produced milk into the duct system. Oxytocin is necessary for the milk ejection reflex, or let-down, in response to suckling, to occur.
      '''),
      ImageContent("assets/images/breast.png")
    ]),
    Subsection('Breast milk', [
      HtmlData('''
      Breast milk is made from nutrients in the mother's bloodstream and bodily stores. It has an optimal balance of fat, sugar, water, and protein that is needed for a baby's growth and development.
      Breasts begin producing mature milk around the third or fourth day after birth. Early in a nursing session, the breasts produce foremilk, a thinner milk containing many proteins and vitamins. If the baby keeps nursing, then hindmilk is produced. Hindmilk has a creamier color and texture because it contains more fat.
      <br/><b>Timing</b><br/>
      Newborn babies typically express demand for feeding everyone to three hours (8–12 times in 24 hours).<br>
       For the first two to four weeks. A newborn has a very small stomach capacity. At one-day old it is 5–7ml, about the size of a large marble; at day three it is 22–30ml, about the size of a ping-pong ball and at day seven it is 45–60ml, or about the size of a golf ball. The amount of breast milk that is produced is timed to meet the infant's needs in that the first milk, colostrum, is concentrated but produced in only very small amounts, gradually increasing in volume to meet the expanding size of the infant's stomach capacity.<br>
       Many newborns will feed for 10 to 15 minutes on each breast. If the infant wants to nurse for a much longer period—say 30 minutes or longer on each breast—they may not be getting enough milk.
       <br/><b>Position</b><br/>
       correct positioning and technique for latching on are necessary to prevent nipple soreness and allow the baby to obtain enough milk.<br>
       Babies can successfully latch on to the breast from multiple positions. Each baby may prefer a particular position.<br>
       The "football" hold places the baby's legs next to the mother's side with the baby facing the mother. Using the "cradle" or "cross-body" hold, the mother supports the baby's head in the crook of her arm. The "cross-over" hold is similar to the cradle hold, except that the mother supports the baby's head with the opposite hand. The mother may choose a reclining position on her back or side with the baby lying next to her.
      '''),
      ImageContent("assets/images/breast_position.png")
    ]),
    Subsection('Health effects', [
      HtmlData('''
      Support for breastfeeding is universal among major health and children's organizations.<br>
      WHO states, "Breast milk is the ideal food for the healthy growth and development of infants; breastfeeding is also an integral part of the reproductive process with important implications for the health of mothers."<br>
      Breastfeeding decreases the risk of a number of diseases in both mothers and babies.
      ''')
    ])
  ]),
  Section('Baby\n(Coming Soon)', []),
  Section('Exercise', []),
  Section('Vaccination', [
    Subsection('Child Vaccination', [
      HtmlData('''
      Vaccination is a simple, safe, and effective way of protecting people against harmful diseases, before they come into contact with them. It uses your body’s natural defenses to build resistance to specific infections and makes your immune system stronger.<br>
      Vaccines train your immune system to create antibodies, just as it does when it’s exposed to a disease. However, because vaccines contain only killed or weakened forms of germs like viruses or bacteria, they do not cause the disease or put you at risk of its complications.<br>
      Most vaccines are given by an injection, but some are given orally (by mouth) or sprayed into the nose.<br>
      Vaccines work by training and preparing the body’s natural defences – the immune system – to recognize and fight off viruses and bacteria. If the body is exposed to those disease-causing pathogens later, it will be ready to destroy them quickly – which prevents illness.<br>
      <strong>Vaccines protect against </strong><a href="https://www.who.int/teams/immunization-vaccines-and-biologicals/diseases">many different diseases</a> including:
      <ul>
      <li><span>Cervical cancer</span></li>
      <li><span>Cholera</span></li>
      <li><span>COVID-19</span></li>
      <li><span>Diphtheria</span></li>
      <li><span>Hepatitis B</span></li>
      <li><span>Influenza</span></li>
      <li><span>Japanese encephalitis</span></li>
      <li><span>Measles</span></li>
      <li><span>Meningitis</span></li>
      <li><span>Mumps</span></li>
      <li><span>Pertussis</span></li>
      <li><span>Pneumonia</span></li>
      <li><span>Polio</span></li>
      <li><span>Rabies</span></li>
      <li><span>Rotavirus</span></li>
      <li><span>Rubella</span></li>
      <li><span>Tetanus</span></li>
      <li><span>Typhoid</span></li>
      <li><span>Varicella</span></li>
      <li><span>Yellow fever</span></li>
      </ul>
      '''),
    ]),
    Subsection('Vaccination tables', [
      PDFContent("assets/pdfs/vaccination1.pdf"),
      PDFContent("assets/pdfs/vaccination2.pdf"),
    ])
  ]),
];
