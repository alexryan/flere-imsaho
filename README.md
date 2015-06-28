
# Mission

The mission of the Flere-Imsaho project is "to enable machines to feel emotions
as well or better than the average human."

This area of research is known as [Affective Computing](https://en.wikipedia.org/wiki/Affective_computing).

We believe that software that can accurately detect the shifting emotional state of humans in real-time will enable a revolutionary new kind of user experience.

A machine that can sense your shifting emotional state in real-time can also be programmed to change its behavior in real-time to be "emotionally calibrated" to that shifting state in a myriad of ways.

"Emotionally aware machines" will be able to offer a more emotionally satisfying user experience by doing less of what generates aversion and more of what generates pleasure. This alone will ensure that the current generation of emotionally uncalibrated software is rendered completely obsolete.

But, more importantly, this technology has the potential to actually assist in the training of the mind to let go of emotionally unhealthy patterns of thinking in favor of more skillful ones.

It can save lives by enabling us to calm down when we are stressed in dangerous situations.

It can help to teach children how to grow up feeling stronger and more self confident that they can realize their dreams in life.

It can help to teach learners of all ages how to push through feelings of discouragement in their studies and to persevere and overcome the challenges thay may otherwise have lead them to quit.

It can help people of all ages to have greater self mastery over their primal drives and to let go of less healthy habits of controlling stress in favor of more healthy ones.

It can help to eradicate the disease of "learned helplessnes" that gives rise depression, mental illness, violence, criminality, suicide, terrorism and war.

It can and will change the very fabric of our society by helping to create a world where people are more tolerant, more emotionally mature and less prone to conflict and violence.

It can help to ensure that human race, in our technological age, does not destroy itself by reducing the probability that ever more easily acquired weapons of mass destruction will find their way into the hands of damaged minds.

It can help to ensure that the passions of human beings are redirected from destructive to constructive ends thereby further accelerating the pace of innovations that prolong the human life span, empower and bring more joy to the lives of others and enable our species to begin populating other worlds.


## Why the strange name?

Flere-Imsaho is the name of a character from the Iain Banks
sci-fi novel
["Player of Games"](http://www.amazon.com/Player-Games-Culture-Iain-Banks/dp/0316005401)

In addition to being an emotionally aware machine, the Flere-Imsaho character is a symbol who represents the idea that "a single determined mind who understands the game and knows how to make the right moves at the right moments can be a catalyst for extraordinary transformational change in the universe".


## How do we get there?: Creating an "affective computing ecosystem"

We envision a future where computers read the shifting emotional state of users from a variety of input signals (audio, visual, heart rate, eeg, etc.), and merge those multiple signals in real-time to build a model of the user’s current emotional state.

One of the uses of this real-time emotional state model will be to offer a user experience that is highly calibrated to the user’s shifting emotional state - in real time.

We believe that we are on the very cusp of an explosion of innovation in affective computing.
However, there are still 2 obstacles that must be overcome before the inevitable explosion of innovation occurs.

1. integration between the various providers of sensory signal data (e.g. activa, beyond verbal, emotiv, etc) isn’t there yet.

2. the barrier to entry is currently still a little too high for applicaton developers

We believe that the solution to both of these challenges is to accelerate the development of an "affective computing ecosystem" of sharing.


### Solving the integration problem

We believe that the [Tellegen-Watson Clarke model](http://bit.ly/1TWdR6y) of affect is the correct model to use to integrate these multiple sensory input signals into the AI mind.
In this model, all conceivable emotional states are simply different combinations :
* arousal: how much energy we have
* valence: whether we are feeling pain (negative valence) or pleasure (positive valence)

For example:
```javascript
low  arousal, low  valence  =>  depression
high arousal, low  valence  =>  anger
low  arousal, high valence  =>  contentment
high arousal, high valence  =>  excitement
```

Providers of signal to the AI brain should provide a stream of arousal and valence values to match the perceived emotional state of the individual being assessed.

### Solving the barrier to entry problem

Ideally, application developers would be able to simply integrate the (arousal, valence) streams of signals from multiple sensory devices to build a real-time model of the users current emotional state and use that model to design their "emotionally aware" application.

However, even in cases where device makers are generating these values, they are often not very accurate. This significantly limits the usefulness of this technology.

Machine learning is used to transform the raw data received by these sensors into (arousal, valence) values. The machine learning algorithms to calculate arousal and valence values from raw sensory input are complicated and the expertise to improve these algorithms is not widespread.

How to accelerate the pace of innovation here?

Recently, intiatives like [Open Source](https://en.wikipedia.org/wiki/Open_source), [Open Data](https://en.wikipedia.org/wiki/Open_data) and [Open Science](https://en.wikipedia.org/wiki/Open_science) and technologies like [Github](https://github.com/) and [DockerHub](https://hub.docker.com/account/signup/) have helped to significantly increase the abilty of researchers to be duplicate each others results and increase the overall pace of innovation.

More so, the experience of [kaggle](https://www.kaggle.com/) has illustrated that offering a challenge to the data science community invariably results in a rapid advancement in the state of the art of machine learning.

This sharing economy offers a challenge to companies who have traditionally sought to survive and thrive by patenting technology and keeping it secret as a means of competitive advantage.

However, as the pace of innovation continues to accelerate, the shelf life of technological competitive advantage has deteriorated.

Incrasingly companies are discovering that the hoarding the knowledge of innovative minds does not lead to sustained competitive advantage.
What does lead to sustained competitive advantage is the abilty to attract and retain the minds that habitually produce such innovations.

We believe that creating an "affective computing ecosystem" of knowledge sharing will conquer the remaining obstacles impeding an explosion of innovation in affective computing and
create a rising tide that will lift all boats.


## First Steps

Our first project involves using machine learning to detect the shifting emotions
of music via the extraction of (arousal, valence) data during the playing of
a musical track.


## [Getting Started] (GettingStarted.md)
